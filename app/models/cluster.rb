class Cluster < ApplicationRecord
  validates :name, presence: true
  has_many :submissions, dependent: :nullify

  before_save :populate_slug!, on: :create

  mount_uploader :header_image, HeaderImageUploader
  process_in_background :header_image

  def self.in_display_order
    order("name DESC")
  end

  def self.active
    where(is_active: true)
  end

  def self.template_list_data
    in_display_order
      .active
      .map do |c|
      c.attributes.symbolize_keys.slice(:name, :description, :is_active, :header_image).merge(
        title: c.name,
        header_image_url: c.header_image.url(:content_card)
      )
    end
  end

  def self.dropdown_options
    select("name as label, name as value, id")
      .active
      .in_display_order
  end

  def populate_slug!
    self.slug = name.parameterize if slug.blank?
  end
end
