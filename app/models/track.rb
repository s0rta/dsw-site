class Track < ApplicationRecord
  include ValidatedVideoUrl

  ICONS = %w[person chart eyeball phone terminal wrench star basecamp martini people lightbulb].freeze
  COLORS = %w[green teal blue purple gold orange headline-session basecamp-session red pink mint].freeze

  validates :name,
    :email_alias,
    :icon,
    :color, presence: true

  validates :color, inclusion: {in: COLORS}
  validates :icon, inclusion: {in: ICONS}

  has_many :submissions, dependent: :restrict_with_error
  has_and_belongs_to_many :chairs, class_name: "User"
  has_and_belongs_to_many :articles, dependent: :restrict_with_error

  mount_uploader :header_image, HeaderImageUploader

  def self.in_display_order
    order("display_order ASC, name ASC")
  end

  def self.with_icon_and_color
    where("icon IS NOT NULL AND color IS NOT NULL")
  end

  def self.submittable
    where(is_submittable: true)
  end

  def self.voteable
    where(is_voteable: true)
  end

  def name_for_partial
    name.downcase.tr(" ", "_")
  end

  def self.template_list_data
    select("name AS title, lower(name) AS track, icon, name, description, color, header_image")
      .in_display_order
      .with_icon_and_color
  end

  def self.dropdown_options
    select("name as label, name as value, is_submittable, id")
      .in_display_order
  end
end
