class Article < ApplicationRecord
  validates :title,
    length: {maximum: 150},
    presence: true

  validates :body,
    presence: true

  has_and_belongs_to_many :tracks
  belongs_to :author, class_name: "User"

  mount_uploader :header_image, HeaderImageUploader
end
