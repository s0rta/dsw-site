class Article < ApplicationRecord
  include ValidatedVideoUrl

  validates :title,
    length: {maximum: 150},
    presence: true

  validates :body,
    presence: true

  has_and_belongs_to_many :tracks, validate: false
  has_many :authorships, dependent: :destroy
  has_many :authors, class_name: "User", through: :authorships, source: :user
  has_one :publishing, as: :subject

  belongs_to :submitter, class_name: "User"
  belongs_to :submission, required: false
  belongs_to :company, required: false

  mount_uploader :header_image, HeaderImageUploader

  accepts_nested_attributes_for :publishing, allow_destroy: true
  accepts_nested_attributes_for :authorships, allow_destroy: true

  def to_param
    "#{id}-#{title.try(:parameterize)}"
  end

  def published?
    publishing.present?
  end

  def publish!
    create_publishing(effective_at: Time.zone.now)
  end

  def unpublish!
    publishing.destroy!
  end
end
