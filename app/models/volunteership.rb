class Volunteership < ApplicationRecord

  include YearScoped

  belongs_to :user
  validates :user, presence: true

  has_many :volunteership_shifts
  has_many :volunteer_shifts, through: :volunteership_shifts

  after_create :send_confirmation_notice

  def send_confirmation_notice
    NotificationsMailer.confirm_volunteer_signup(self).deliver_now
  end
end
