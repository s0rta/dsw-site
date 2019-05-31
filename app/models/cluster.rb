class Cluster < ApplicationRecord
  validates :name, presence: true
  has_many :submissions, dependent: :nullify

  mount_uploader :header_image, HeaderImageUploader

  def self.in_display_order
    order("name DESC")
  end

  def self.active
    where(is_active: true)
  end
end
