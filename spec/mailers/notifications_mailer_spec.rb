require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  let(:session) { build(:submission) }

  describe "the thanks e-mail" do
    let(:mail) { described_class.session_thanks(session) }

    it "renders properly" do
      expect(mail).to deliver_from("Denver Startup Week <info@email.denverstartupweek.org>")
      expect(mail).to deliver_to(session.submitter.email, session.contact_email)
      expect(mail).to have_subject("Thank you, DSW session organizers!")
    end
  end

  describe "the new article notification e-mail" do
    before do
      ENV["NEW_ARTICLE_EMAIL_RECIPIENTS"] = "test1@example.com,test2@example.com"
    end
    let(:article) { create(:article) }
    let(:mail) { described_class.notify_of_new_article(article) }

    it "renders properly" do
      expect(mail).to deliver_from("Denver Startup Week <info@email.denverstartupweek.org>")
      expect(mail).to deliver_to("test1@example.com", "test2@example.com")
      expect(mail).to have_subject("A new article has been submitted for DSW")
    end
  end

  describe "the new resource notification e-mail" do
    let(:resource) { create(:resource) }
    let(:mail) { described_class.notify_of_new_resource(resource) }

    it "renders properly" do
      expect(mail).to deliver_from("Denver Startup Week <info@email.denverstartupweek.org>")
      expect(mail).to deliver_to("info@denverstartupweek.org")
      expect(mail).to have_subject("A new resource has been submitted for DSW")
    end
  end
end
