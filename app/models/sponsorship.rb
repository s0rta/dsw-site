class Sponsorship < ApplicationRecord

  TITLE_LEVEL = 'title'.freeze
  TRACK_LEVEL = 'track'.freeze
  HEADLINE_LEVEL = 'headline'.freeze
  PARTNER_LEVEL = 'partner'.freeze
  MEMBER_LEVEL = 'member'.freeze
  IN_KIND_LEVEL = 'in-kind'.freeze
  MEDIA_LEVEL = 'media'.freeze

  AMBASSADOR_HOST_LEVEL = 'ambassador host'.freeze
  AMBASSADOR_SPONSOR_LEVEL = 'ambassador_sponsor'.freeze
  AMBASSADOR_PARTNER_LEVEL = 'ambassador_partner'.freeze

  LEVELS = [ TITLE_LEVEL,
             TRACK_LEVEL,
             HEADLINE_LEVEL,
             PARTNER_LEVEL,
             MEMBER_LEVEL,
             MEDIA_LEVEL,
             IN_KIND_LEVEL,
             AMBASSADOR_HOST_LEVEL,
             AMBASSADOR_SPONSOR_LEVEL,
             AMBASSADOR_PARTNER_LEVEL ].freeze

  SPONSORSHIP_PAGE_LEVELS = LEVELS - [
             AMBASSADOR_HOST_LEVEL,
             AMBASSADOR_SPONSOR_LEVEL,
             AMBASSADOR_PARTNER_LEVEL ].freeze

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

  def self.for_sponsorship_page
    where(level: SPONSORSHIP_PAGE_LEVELS)
  end

  def self.title
    where(level: 'title')
  end

  def self.alphabetical
    order('name ASC')
  end
end
