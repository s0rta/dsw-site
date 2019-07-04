require "spec_helper"

feature "Registering to attend" do
  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  let(:submitter) do
    create(:user, email: "test@example.com",
                  password: "password")
  end

  let(:track) do
    create(:track, name: "Founder",
                   is_submittable: true)
  end

  let!(:submission) do
    create(:submission,
      submitter: submitter,
      title: "I am a session",
      description: "interesting stuff",
      track: track,
      contact_email: "test@example.com",
      state: "confirmed",
      start_day: 2,
      start_hour: 10,
      end_day: 2,
      end_hour: 11.5,
      year: AnnualSchedule.current.year)
  end

  describe "when registration is open" do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime + 1.day
    end

    before do
      create(:company, name: "Example.com")
      create(:attendee_goal, name: "inspiration", description: "Be inspired")
      create(:attendee_goal, name: "skills", description: "Improve my skills")
    end

    scenario "Registering to attend from the schedule page" do
      pending("refactor")
      visit "/schedule"
      click_link "I am a session"
      click_link "Add to Schedule"
      click_link "Create an account"
      fill_in "Name", with: "Test Registrant"
      fill_in "E-mail Address", with: "test2@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirm Password", with: "password"
      click_button "Sign Up"
      select "he/him/his", from: "registration_gender"
      select "25-34 years old", from: "registration_age_range"
      select "Founder", from: "registration_track_id"

      # Use the autocompleter to select
      fill_in "registration_company_name", with: "Exa"
      find(".awesomplete li", text: "Example.com").click

      select "Design", from: "registration_primary_role"
      fill_in "registration_zip", with: "12345"

      select "Be inspired", from: "registration_attendee_goal_ids"
      select "Improve my skills", from: "registration_attendee_goal_ids"

      check "registration_coc_acknowledgement"
      click_button "Register"
      expect(page).to have_content("Thanks for registering!")

      reg = Registration.last
      expect(reg.primary_role).to eq("Design")
      expect(reg.age_range).to eq("25-34 years old")
      expect(reg.track.name).to eq("Founder")
      expect(reg.gender).to eq("he/him/his")
      expect(reg.company.name).to eq("Example.com")
      expect(reg.attendee_goals.map(&:name)).to include("Improve my skills")
      expect(reg.attendee_goals.map(&:name)).to include("Be inspired")

      # Confirmation e-mail
      email = ActionMailer::Base.deliveries.detect { |e| e.to.include?("test2@example.com") }
      expect(email.subject).to eq("You are registered for Denver Startup Week #{Date.today.year}")

      select("Founder Track", from: "filter")

      click_link "I am a session"
      click_link "Add to Schedule"
      visit "/schedule"
      select "View My Schedule", from: "filter"
      ical = URI.open(find(:link, "Add to Outlook/iCal")[:href].gsub("webcal://", "http://"))
      calendars = Icalendar.parse(ical)
      expect(calendars.first.events.size).to eq(1)
      expect(calendars.first.events.first.summary).to eq("I am a session")
    end
  end

  describe "when registration is closed" do
    before do
      travel_to AnnualSchedule.current.registration_open_at.to_datetime - 1.day
    end

    scenario "User tries to register when registrations are closed" do
      visit "/registration/new"
      expect(page).to have_content("Registration for #{Date.today.year} is currently closed")
      expect(current_path).to eq("/registration/closed")
    end
  end
end
