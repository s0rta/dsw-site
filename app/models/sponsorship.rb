class Sponsorship < ApplicationRecord

  TITLE_LEVEL = 'title'.freeze
  TRACK_LEVEL = 'track'.freeze
  HEADLINE_LEVEL = 'headline'.freeze
  PARTNER_LEVEL = 'partner'.freeze
  MEMBER_LEVEL = 'member'.freeze

  LEVELS = [ TITLE_LEVEL,
             TRACK_LEVEL,
             HEADLINE_LEVEL,
             PARTNER_LEVEL,
             MEMBER_LEVEL ].freeze

  belongs_to :track, optional: true

  include YearScoped

  validates :name,
            :link_href,
            :year, presence: true

  validates :level,
            presence: true,
            inclusion: { in: LEVELS }

  def self.title
    where(level: 'title')
  end

  def self.alphabetical
    order('name ASC')
  end
end
