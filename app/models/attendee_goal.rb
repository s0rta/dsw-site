class AttendeeGoal < ApplicationRecord

  has_many :registration_attendee_goals, dependent: :restrict_with_error
  has_many :registrations, through: :registration_attendee_goals

  validates :name,
            :description,
            presence: true

  def self.active
    where(is_active: true)
  end

end
