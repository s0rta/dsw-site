require "spec_helper"

feature "Subscribing to the newsletter" do
  scenario "from the page footer" do
    visit "/"
    fill_in "Email Address", with: "test@example.com"
    page.execute_script("document.querySelector('input[type=\"submit\"]').scrollIntoView(false)")
    click_button "Get Updates"
    expect(page).to have_button("Thanks! You are signed up for updates.", disabled: true)
    expect(NewsletterSignup.last.email).to eq("test@example.com")
  end
end
