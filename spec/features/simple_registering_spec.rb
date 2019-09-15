require "spec_helper"

feature "Registering to attend (via kiosk)" do
  before do
    visit "/enable-simple-reg"
    create(:company, name: "Example.com")
    create(:attendee_goal, name: "inspiration", description: "Be inspired")
    create(:attendee_goal, name: "skills", description: "Improve my skills")
    create(:ethnicity, name: "Black / African American")
    create(:ethnicity, name: "Latino")
  end

  before do
    travel_to AnnualSchedule.current.registration_open_at.to_datetime + 1.day
  end

  after do
    visit "/disable-simple-reg"
  end

  let!(:track) do
    create :track, name: "Founder",
                   is_submittable: true
  end

  scenario "Registering to attend" do
    visit "/"
    click_link "Register to Attend"
    fill_in "First and Last Name", with: "Test Registrant"
    fill_in "E-mail Address", with: "test2@example.com"
    select "he/him/his", from: "registration_gender"
    select "25-34 years old", from: "registration_age_range"
    check "Black / African American"
    check "Latino"
    select "Founder", from: "registration_track_id"

    fill_in "registration_company_name", with: "Exa"
    find(".awesomplete li", text: "Example.com").click

    select "Arts and Design", from: "registration_primary_role"
    fill_in "registration_zip", with: "12345"

    check "Be inspired"
    check "Improve my skills"

    check "registration_coc_acknowledgement"
    click_button "Submit"
    expect(page).to have_content("Thanks for registering!")
    expect(current_path).to include("/schedule")
    user = User.where(email: "test2@example.com").first!
    expect(user.name).to eq("Test Registrant")
    expect(user.current_registration.company.name).to eq("Example.com")
    expect(user.current_registration.primary_role).to eq("Arts and Design")
  end

  scenario "Registering to attend with a preexisting account" do
    user = User.create!(email: "test2@example.com",
                        password: "password",
                        password_confirmation: "password",
                        name: "Preexisting Registrant")
    visit "/"
    click_link "Register to Attend"
    fill_in "First and Last Name", with: "Test Registrant"
    fill_in "E-mail Address", with: "test2@example.com"
    select "he/him/his", from: "registration_gender"
    select "25-34 years old", from: "registration_age_range"
    check "Black / African American"
    check "Latino"
    select "Founder", from: "registration_track_id"

    fill_in "registration_company_name", with: "Exa"
    find(".awesomplete li", text: "Example.com").click

    select "Arts and Design", from: "registration_primary_role"
    fill_in "registration_zip", with: "12345"

    check "Be inspired"
    check "Improve my skills"

    check "registration_coc_acknowledgement"
    click_button "Submit"
    expect(page).to have_content("Thanks for registering")
    expect(current_path).to include("/schedule")
    expect(user.reload.name).to eq("Preexisting Registrant")
    expect(user.current_registration.company.name).to eq("Example.com")
    expect(user.current_registration.primary_role).to eq("Arts and Design")
  end
end
