require "spec_helper"

feature "Submitting a resource" do
  let!(:support_area) { create(:support_area, name: "Unicorn Ranches") }
  let!(:industry_type) { create(:industry_type, name: "Quadriped Support") }
  let!(:company) { create(:company, name: 'Rainbow Sparkles') }

  scenario "User submits a new resource" do
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/give_too/resources/new"

    fill_in "Resource Name", with: "I am a resource"
    check "Unicorn Ranches"
    select "Rainbow Sparkles", from: "resource_company_id"
    fill_in "Contact Information*", with: "123-456-7891"

    # Adding to contenteditable is a bit more involved
    resource_description_el = find(".ResourcesForm-textarea.medium-editor-element")
    resource_description_el.click
    resource_description_el.send_keys "Please use me."

    click_button "Submit"
    expect(page).to have_content("Thanks! Your resource has been received.")

    visit "/give_too/resources"
    # See it in the list
    expect(page).to have_css(".ResourceCard", text: "I am a resource")
    expect(page).to have_css(".ResourceCard", text: "Please use me.")

    # Notification e-mail
    email = ActionMailer::Base.deliveries.detect { |e| e.to.include?("info@denverstartupweek.org") }
    expect(email.subject).to eq("A new resource has been submitted for DSW")

    resource = Resource.last
    expect(resource.support_areas.map(&:name)).to include("Unicorn Ranches")

    # Publish and view
    find(".ResourceCard a").click
    expect(page).to have_css(".Resource-name", text: "I AM A RESOURCE")
  end

  scenario "User submits a new article but runs into errors" do
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/give_too/resources/new"

    fill_in "Resource Name", with: "I am a resource"
    fill_in "Contact Information*", with: "123-456-7891"

    click_button "Submit"
    expect(page).to have_content("Please correct the following errors: Description can't be blank")
    expect(Resource.count).to eq(0)
  end

  scenario "User submits a new article but fails the captcha check" do
    allow(Recaptcha).to receive(:skip_env?).and_return(false)
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/give_too/resources/new"

    fill_in "Resource Name", with: "I am a resource"
    fill_in "Contact Information*", with: "123-456-7891"

    click_button "Submit"

    expect(page).to have_content("reCAPTCHA verification failed, please try again.")
  end

  scenario "User edits an existing article" do
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/give_too/resources/new"

    fill_in "Resource Name", with: "I am a resource"
    check "Unicorn Ranches"
    select "Rainbow Sparkles", from: "resource_company_id"
    fill_in "Contact Information*", with: "123-456-7891"

    # Adding to contenteditable is a bit more involved
    resource_description_el = find(".ResourcesForm-textarea.medium-editor-element")
    resource_description_el.click
    resource_description_el.send_keys "Please use me."

    click_button "Submit"
    expect(page).to have_content("Thanks! Your resource has been received.")

    visit "/give_too/resources/#{Resource.last.id}/edit"

    fill_in "Resource Name", with: "This is a much better resource"
    click_button "Submit"

    expect(page).to have_content "Thanks! Your resource update has been received."

    visit "/give_too/resources/#{Resource.last.id}"

    expect(page).to have_css(".Resource-name", text: "THIS IS A MUCH BETTER RESOURCE")
    expect(page).not_to have_css(".Resource-name", text: "I AM A RESOURCE")
  end
end
