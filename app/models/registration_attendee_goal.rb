class RegistrationAttendeeGoal < ApplicationRecord
  belongs_to :registration
  belongs_to :attendee_goal
end
