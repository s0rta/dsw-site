# frozen_string_literal: true

class SentNotification < ActiveRecord::Base

  ACCEPTANCE_KIND = 'accepted'
  KINDS = [ ACCEPTANCE_KIND ].freeze

  belongs_to :submission

  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :recipient_email, presence: true
end
