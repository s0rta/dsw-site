require "spec_helper"

feature "GiveToo ideas" do
  describe "when submissions are open" do
    let!(:company) { create(:company, name: "Example.com") }

    before do
      travel_to AnnualSchedule.current.cfp_open_at.to_datetime + 1.day
    end

    after do
      travel_back
    end

    scenario "User submits a new idea" do
      visit "/"
      click_on "Open Main Menu"
      click_on "#GiveToo"

      click_on "Submit an idea"
      fill_in "Name", with: "New Guy"
      fill_in "E-mail Address", with: "test@example.com"
      fill_in "Password", with: "password", match: :prefer_exact
      fill_in "Confirm Password", with: "password", match: :prefer_exact

      click_on "Submit"

      click_on "Submit an idea"

      binding.pry
      select "Event", from: "givetoo_idea_kind"
      fill_in "givetoo_idea_title", with: "Some talk"
      fill_in "givetoo_idea_description", with: "I am going to give a talk."

      # Use the autocompleter to select
      # fill_in "submission_company_name", with: "Exa"
      # find(".awesomplete li", text: "Example.com").click

      click_button "Submit"
      expect(page).to have_content("Thanks!")

      # See it in the list
      expect(page).to have_css(".SessionCard", text: "SOME TALK")
      expect(page).to have_css(".SessionCard", text: "BIZNESS")
      expect(page).to have_css(".SessionCard", text: "I am going to give a talk.")

      # Confirmation to track chair
      email = ActionMailer::Base.deliveries.detect { |e| e.to.include?("chair@example.com") }
      expect(email.subject).to eq("A new DSW submission has been received for the Bizness track")

      # Confirmation to submitter
      email = ActionMailer::Base.deliveries.detect { |e| e.to.include?("test2@example.com") }
      expect(email.subject).to eq("Thanks for submitting a session proposal for Denver Startup Week!")
    end
  end
end
