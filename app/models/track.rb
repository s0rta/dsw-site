class Track < ApplicationRecord

  ICONS = %w[person chart eyeball phone terminal wrench star basecamp martini].freeze
  COLORS = %w[green teal blue purple gold orange headline-session basecamp-session red].freeze

  validates :name,
            :email_alias,
            :icon,
            :color, presence: true

  validates :color, inclusion: { in: COLORS }
  validates :icon, inclusion: { in: ICONS }

  has_many :submissions, dependent: :destroy
  has_and_belongs_to_many :chairs, class_name: 'User'

  def self.in_display_order
    order('display_order ASC, name ASC')
  end

  def self.with_icon_and_color
    where('icon IS NOT NULL AND color IS NOT NULL')
  end

  def self.submittable
    where(is_submittable: true)
  end

  def self.voteable
    where(is_voteable: true)
  end

  def name_for_partial
    name.downcase.tr(' ', '_')
  end
end
