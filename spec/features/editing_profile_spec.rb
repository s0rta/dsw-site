require "spec_helper"

feature "Editing my profile" do
  before do
    allow(ListSubscriptionJob).to receive(:perform_async)
  end

  scenario "Editing an account from the dashboard" do
    visit "/dashboard"
    fill_in "First and Last Name", with: "Test Registrant"
    fill_in "E-mail Address", with: "test2@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_button "Submit"
    click_link "Edit Profile"
    attach_file("user_avatar",
      Rails.root.join("spec", "support", "avatar_examples", "more_than_2_mb.jpg"),
      make_visible: true)
    page.driver.browser.switch_to.alert.accept
    attach_file("user_avatar",
      Rails.root.join("spec", "support", "avatar_examples", "less_than_2_mb.png"),
      make_visible: true)
    fill_in "First and Last Name", with: "Test Registrant 2"
    fill_in "user_current_password", with: "password"
    click_button "Update"
    expect(page).to have_css(".Dashboard-profile-name", text: "Test Registrant 2")
    expect(page).to have_css('.Avatar-image[src$="less_than_2_mb.png"]')
  end
end
