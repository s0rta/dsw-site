# frozen_string_literal: true

class SentNotification < ActiveRecord::Base

  ACCEPTANCE_KIND = 'accepted'
  REJECTION_KIND = 'rejected'
  VENUE_MATCH_KIND = 'venue_match'
  WAITLISTING_KIND = 'waitlisted'
  KINDS = [ ACCEPTANCE_KIND,
            REJECTION_KIND,
            VENUE_MATCH_KIND,
            WAITLISTING_KIND ].freeze

  belongs_to :submission

  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :recipient_email, presence: true
end
