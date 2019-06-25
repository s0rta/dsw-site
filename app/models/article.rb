class Article < ApplicationRecord
  validates :title,
    length: {maximum: 150},
    presence: true

  validates :body,
    presence: true

  has_and_belongs_to_many :tracks, validate: false
  has_many :authorships, dependent: :destroy
  has_many :authors, class_name: "User", through: :authorships
  has_one :publishing, as: :subject

  belongs_to :submission, required: false
  belongs_to :company, required: false

  mount_uploader :header_image, HeaderImageUploader

  def to_param
    "#{id}-#{title.try(:parameterize)}"
  end
end
