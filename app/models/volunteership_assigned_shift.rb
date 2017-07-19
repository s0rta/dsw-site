class VolunteershipAssignedShift < ApplicationRecord
  belongs_to :volunteership
  belongs_to :assigned_shift, class_name: 'VolunteerShift', foreign_key: 'volunteer_shift_id'
end
