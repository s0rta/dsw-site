# frozen_string_literal: true

class SentNotification < ActiveRecord::Base

  ACCEPTANCE_KIND = 'accepted'
  REJECTION_KIND = 'rejected'
  KINDS = [ ACCEPTANCE_KIND, REJECTION_KIND ].freeze

  belongs_to :submission

  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :recipient_email, presence: true
end
