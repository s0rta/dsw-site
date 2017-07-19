class Volunteership < ApplicationRecord

  include YearScoped

  belongs_to :user
  validates :user, presence: true

  has_many :volunteership_available_shifts
  has_many :available_shifts, through: :volunteership_available_shifts, class_name: 'VolunteerShift'

  has_many :volunteership_assigned_shifts
  has_many :assigned_shifts, through: :volunteership_assigned_shifts, class_name: 'VolunteerShift'

  after_create :send_confirmation_notice

  def send_confirmation_notice
    NotificationsMailer.confirm_volunteer_signup(self).deliver_now
  end
end
