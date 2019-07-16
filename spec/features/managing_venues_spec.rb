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

  scenario "a user who does not have any venues assigned should not see anything in the list" do
    login_as user, scope: :user
    visit "/dashboard"
    expect(page).to have_content("You do not have any venues assigned.")
  end

  scenario "a user who has venues assigned should be able to edit their availability" do
    login_as venue_host_user, scope: :user
    create(:venue, company: company, name: "Example Theatre")

    visit "/dashboard"
    find(".ArticleCard").click
  end
end
