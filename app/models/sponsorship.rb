class Sponsorship < ApplicationRecord

  TITLE_LEVEL = 'title'.freeze
  TRACK_LEVEL = 'track'.freeze
  HEADLINE_LEVEL = 'headline'.freeze
  PARTNER_LEVEL = 'partner'.freeze
  MEMBER_LEVEL = 'member'.freeze
  IN_KIND_LEVEL = 'in-kind'.freeze

  LEVELS = [ TITLE_LEVEL,
             TRACK_LEVEL,
             HEADLINE_LEVEL,
             PARTNER_LEVEL,
             MEMBER_LEVEL,
             IN_KIND_LEVEL ].freeze

  belongs_to :track, optional: true
  belongs_to :submission, optional: true

  include YearScoped

  mount_uploader :logo, LogoUploader

  validates :name,
            :link_href,
            :logo,
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
