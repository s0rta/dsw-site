class AnnualSchedule < ApplicationRecord

  CFP_CYCLE = 'cfp'.freeze
  VOTING_CYCLE = 'voting'.freeze
  REGISTRATION_CYCLE = 'registration'.freeze
  WEEK_CYCLE = 'week'.freeze
  POST_WEEK_CYCLE = 'post_week'.freeze
  PITCH_APPLICATION_CYCLE = 'pitch_application'.freeze
  PITCH_VOTING_CYCLE = 'pitch_voting'.freeze
  AMBASSADOR_APPLICATION_CYCLE = 'ambassador_application'.freeze
  SPONSORSHIP_CYCLE = 'sponsorship'.freeze

  CYCLES = [ CFP_CYCLE,
             VOTING_CYCLE,
             REGISTRATION_CYCLE,
             WEEK_CYCLE,
             POST_WEEK_CYCLE,
             PITCH_APPLICATION_CYCLE,
             PITCH_VOTING_CYCLE,
             AMBASSADOR_APPLICATION_CYCLE,
             SPONSORSHIP_CYCLE ].freeze

  validates :week_start_at,
            :week_end_at,
            presence: true

  validates :year,
            presence: true,
            uniqueness: true

  jsonb_accessor :dates,
                 cfp_open_at: :date,
                 cfp_close_at: :date,
                 voting_open_at: :date,
                 voting_close_at: :date,
                 registration_open_at: :date,
                 week_start_at: :date,
                 week_end_at: :date,
                 sponsorship_open_at: :date,
                 sponsorship_close_at: :date,
                 pitch_application_open_at: :date,
                 pitch_application_close_at: :date,
                 pitch_voting_open_at: :date,
                 pitch_voting_close_at: :date,
                 ambassador_application_open_at: :date,
                 ambassador_application_close_at: :date

  class << self
    def current
      where(year: Date.today.year).first
    end

    def next
      where(year: Date.today.year + 1).first
    end

    delegate :cfp_open?, to: :current
    delegate :voting_open?, to: :current
    delegate :registration_open?, to: :current
    delegate :pitch_application_open?, to: :current
    delegate :pitch_voting_open?, to: :current
    delegate :sponsorship_open?, to: :current
    delegate :ambassador_application_open?, to: :current
    delegate :in_week?, to: :current
    delegate :post_week?, to: :current
    delegate :active_cycles, to: :current
  end

  def cfp_open?
    Time.zone.now > date_in_time_zone(cfp_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(cfp_close_at).at_end_of_day
  end

  def voting_open?
    Time.zone.now > date_in_time_zone(voting_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(voting_close_at).at_end_of_day
  end

  def registration_open?
    Time.zone.now > date_in_time_zone(registration_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(week_end_at).at_end_of_day
  end

  def pitch_application_open?
    Time.zone.now > date_in_time_zone(pitch_application_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(pitch_application_close_at).at_end_of_day
  end

  def pitch_voting_open?
    Time.zone.now > date_in_time_zone(pitch_voting_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(pitch_voting_close_at).at_end_of_day
  end

  def sponsorship_open?
    Time.zone.now > date_in_time_zone(sponsorship_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(sponsorship_close_at).at_end_of_day
  end

  def ambassador_application_open?
    Time.zone.now > date_in_time_zone(ambassador_application_open_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(ambassador_application_close_at).at_end_of_day
  end

  def in_week?
    Time.zone.now > date_in_time_zone(week_start_at).at_beginning_of_day &&
      Time.zone.now < date_in_time_zone(week_end_at).at_end_of_day
  end

  def post_week?
    Time.zone.now > date_in_time_zone(week_end_at).at_end_of_day
  end

  def active_cycles
    cycles = []
    cycles << CFP_CYCLE if cfp_open?
    cycles << VOTING_CYCLE if voting_open?
    cycles << REGISTRATION_CYCLE if registration_open?
    cycles << WEEK_CYCLE if in_week?
    cycles << POST_WEEK_CYCLE if post_week?
    cycles << PITCH_APPLICATION_CYCLE if pitch_application_open?
    cycles << PITCH_VOTING_CYCLE if pitch_voting_open?
    cycles << SPONSORSHIP_CYCLE if pitch_application_open?
    cycles << AMBASSADOR_APPLICATION_CYCLE if ambassador_application_open?
    cycles << SPONSORSHIP_CYCLE if sponsorship_open?
    cycles
  end

  private

  def date_in_time_zone(date, zone = 'America/Denver')
    date.in_time_zone(ActiveSupport::TimeZone[zone])
  end

end
