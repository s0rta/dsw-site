require "spec_helper"

feature "Managing My Venue" do
  let(:user) do
    create(:user, email: "test@example.com", password: "password")
  end

  let(:company) { create(:company, name: "ExampleCo") }

  let(:venue_host_user) do
    create(:user, email: "test@example.com", password: "password").tap do |u|
      u.companies << company
    end
  end

  before(:each) do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  scenario "a user who is not a venue host should not see the 'My Venues' tab" do
    Flipper[:venue_admin].disable
    login_as user, scope: :user
    visit "/dashboard"

    expect(page).to_not have_link("My Venues")
  end

  scenario "a user who is a venue host should be able to create new venues" do
    pending("refactor")

    Flipper[:venue_admin].enable
    login_as venue_host_user, scope: :user

    visit "/dashboard"

    expect(page).to have_link("My Venues")
    click_on "My Venues"

    click_on "New Venue"

    fill_in "Venue Name", with: "test venue"

    # Use the autocompleter to select
    fill_in "venue_company_name", with: "Exa"
    find(".awesomplete li", text: "ExampleCo").click

    fill_in "Description", with: "some description"
    fill_in "Address", with: "111"
    fill_in "City", with: "Denver"
    fill_in "State", with: "Colorado"

    click_button "Submit"

    expect(page).to have_content("Venue was successfully created.")
    expect(page).to have_content("test venue")
  end
end
