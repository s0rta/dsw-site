require "spec_helper"

feature "Submitting an article" do
  before do
    ENV["NEW_ARTICLE_EMAIL_RECIPIENTS"] = "editor@example.com"
  end

  let!(:track) { create(:track, name: "Sports!", is_submittable: true) }

  scenario "User submits a new article" do
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/dashboard" # More straightforward than waiting for the flash to disappear

    click_on "Submit Article"
    fill_in "Article Title", with: "I am an article"
    check "Sports!"

    # Adding to contenteditable is a bit more involved
    article_body_el = find(".ArticlesForm-textarea")
    article_body_el.click
    article_body_el.send_keys "Please read me."

    # Use the autocompleter to select
    fill_in "Author", with: "New G"
    find(".awesomplete li", text: "New Guy").click

    click_button "Submit"
    expect(page).to have_content("Thanks! Your article has been received.")

    # See it in the list
    expect(page).to have_css(".ArticleCard", text: "NOT YET PUBLISHED")
    expect(page).to have_css(".ArticleCard", text: "I am an article")
    expect(page).to have_css(".ArticleCard", text: "Please read me.")

    # Notification e-mail
    email = ActionMailer::Base.deliveries.detect { |e| e.to.include?("editor@example.com") }
    expect(email.subject).to eq("A new article has been submitted for DSW")

    article = Article.last
    expect(article.tracks.map(&:name)).to include("Sports!")

    # Publish and view
    article.publish!
    find(".ArticleCard a").click
    expect(page).to have_css(".Article-title", text: "I AM AN ARTICLE")
  end

  scenario "User submits a new article but runs into errors" do
    visit "/"
    click_on "Sign Up / Sign In"
    fill_in "Name", with: "New Guy"
    fill_in "E-mail Address", with: "test@example.com"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Confirm Password", with: "password", match: :prefer_exact

    click_on "Submit"
    visit "/dashboard" # More straightforward than waiting for the flash to disappear

    click_on "Submit Article"
    fill_in "Article Title", with: "I am an article"

    click_button "Submit"
    expect(page).to have_content("Please correct the following errors: Body can't be blank")
    expect(Article.count).to eq(0)
  end

  # scenario "User edits an existing article" do
  #   visit "/"
  #   click_on "Sign Up / Sign In"
  #   fill_in "Name", with: "New Guy"
  #   fill_in "E-mail Address", with: "test@example.com"
  #   fill_in "Password", with: "password", match: :prefer_exact
  #   fill_in "Confirm Password", with: "password", match: :prefer_exact

  #   click_on "Submit"
  #   visit "/dashboard" # More straightforward than waiting for the flash to disappear

  #   click_on "Submit New Proposal"
  #   select "Bizness", from: "submission_track_id"
  #   fill_in "submission_title", with: "Some talk"
  #   fill_in "submission_description", with: "I am going to give a talk."
  #   fill_in "submission_notes", with: "Please pick my talk."
  #   fill_in "submission_target_audience_description", with: "People who like talks."
  #   fill_in "submission_contact_email", with: "test2@example.com"
  #   check "submission_coc_acknowledgement"
  #   click_button "Submit"

  #   click_on "Propose Updates"
  #   fill_in "submission_title", with: "Updated talk"
  #   fill_in "submission_description", with: "Here is my udpated idea"
  #   fill_in "submission_notes", with: "I have even more things to say now."
  #   click_button "Submit"

  #   expect(page).to have_css(".SessionCard", text: "SOME TALK")
  #   expect(page).to have_content "Thanks! Your changes have been submitted and are pending review."

  #   submission = Submission.last
  #   submission.promote_updates!
  #   visit page.current_path

  #   expect(page).to have_css(".SessionCard", text: "UPDATED TALK")
  #   expect(page).not_to have_css(".SessionCard", text: "SOME TALK")
  #   expect(last_email_sent).to deliver_to("test@example.com", "test2@example.com")
  #   expect(last_email_sent).to have_subject "Your proposed session updates have been accepted"
  #   expect(submission.sent_notifications.last.kind).to eq(SentNotification::UPDATES_ACCEPTED_KIND)
  # end
end
