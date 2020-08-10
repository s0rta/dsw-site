class GeneralInquiry < ApplicationRecord
  after_create :notify_inbox,
    :subscribe_to_list

  INTEREST_MENTORSHIP = "mentorship".freeze
  INTEREST_PITCH_COMPETITION = "pitch".freeze
  INTEREST_CRAWL = "crawl".freeze

  INTERESTS = {
    "sponsorship" => "Sponsorship",
    "volunteer" => "Volunteering at events",
    "mentorship" => "Being a mentor",
    "venue_host" => "Being a venue host",
    "job_fair" => "Exhibiting at the Job Fair",
    "irl" => "Exhibiting at the IRL Physical Product Showcase",
    "crawl" => "Being a stop on the Startup Crawl",
    "pitch" => "Competing in the Pitch Challenge",
    "other" => "Something else entirely"
  }.freeze

  validates :interest,
    inclusion: {in: INTERESTS.keys, allow_blank: true}

  def notify_inbox
    NotificationsMailer.notify_of_new_inquiry(self).deliver_now
  end

  def subscribe_to_list
    ListSubscriptionJob.perform_async contact_email
  end
end
