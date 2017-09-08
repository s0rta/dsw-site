class AttendeeMessage < ApplicationRecord
  belongs_to :submission

  validates :subject, presence: true, length: { maximum: 100 }
  validates :body, presence: true

  def sent?
    sent_at.present?
  end

  def sent_status
    if sent?
      "Sent at #{sent_at.to_s(:long)}"
    else
      "Unsent"
    end
  end
end
