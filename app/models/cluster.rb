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

  def self.template_list_data
    select("name AS title, name, description, is_active, header_image")
      .in_display_order
      .active
  end
end
