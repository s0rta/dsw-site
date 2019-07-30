class Ambassador < ApplicationRecord
  include YearScoped

  validates :first_name,
    :last_name,
    :company,
    :title,
    :location,
    presence: true

  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar
end
