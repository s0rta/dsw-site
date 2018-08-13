class Sponsorship < ApplicationRecord

  TITLE_LEVEL = 'title'.freeze
  TRACK_LEVEL = 'track'.freeze
  HEADLINE_LEVEL = 'headline'.freeze
  PARTNER_LEVEL = 'partner'.freeze
  MEMBER_LEVEL = 'member'.freeze
  IN_KIND_LEVEL = 'in-kind'.freeze
  MEDIA_LEVEL = 'media'.freeze
  PODCAST_LEVEL = 'podcast'.freeze
  PITCH_LEVEL = 'pitch'.freeze

  AMBASSADOR_HOST_LEVEL = 'ambassador host'.freeze
  AMBASSADOR_SPONSOR_LEVEL = 'ambassador_sponsor'.freeze
  AMBASSADOR_PARTNER_LEVEL = 'ambassador_partner'.freeze

  LEVELS = [ TITLE_LEVEL,
             TRACK_LEVEL,
             HEADLINE_LEVEL,
             PITCH_LEVEL,
             PARTNER_LEVEL,
             MEMBER_LEVEL,
             PODCAST_LEVEL,
             MEDIA_LEVEL,
             IN_KIND_LEVEL,
             AMBASSADOR_HOST_LEVEL,
             AMBASSADOR_SPONSOR_LEVEL,
             AMBASSADOR_PARTNER_LEVEL ].freeze

  AMBASSADORS_PAGE_LEVELS = [ AMBASSADOR_HOST_LEVEL,
                              AMBASSADOR_SPONSOR_LEVEL,
                              AMBASSADOR_PARTNER_LEVEL ].freeze

  SPONSORS_PAGE_LEVELS = (LEVELS - AMBASSADORS_PAGE_LEVELS).freeze

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

  def self.for_sponsors_page
    where(level: SPONSORS_PAGE_LEVELS)
  end

  def self.title
    where(level: TITLE_LEVEL)
  end

  def self.alphabetical
    order('name ASC')
  end
end
