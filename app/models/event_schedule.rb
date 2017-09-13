module EventSchedule

  CFP_CYCLE = 'cfp'.freeze
  VOTING_CYCLE = 'voting'.freeze
  REGISTRATION_CYCLE = 'registration'.freeze
  WEEK_CYCLE = 'week'.freeze
  PITCH_APPLICATION_CYCLE = 'pitch_application'.freeze
  PITCH_VOTING_CYCLE = 'pitch_voting'.freeze
  AMBASSADOR_APPLICATION_CYCLE = 'ambassador_application'.freeze
  SPONSORSHIP_CYCLE = 'sponsorship'.freeze

  CYCLES = [ CFP_CYCLE,
             VOTING_CYCLE,
             REGISTRATION_CYCLE,
             WEEK_CYCLE,
             PITCH_APPLICATION_CYCLE,
             PITCH_VOTING_CYCLE,
             AMBASSADOR_APPLICATION_CYCLE,
             SPONSORSHIP_CYCLE ].freeze

  SUBMISSION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-03-19').freeze
  SUBMISSION_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-04-21').freeze

  VOTING_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-10').freeze
  VOTING_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-29').freeze

  REGISTRATION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-07-20').freeze

  WEEK_START_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-25').freeze
  WEEK_END_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-29').freeze

  PITCH_APPLICATION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-08-08').freeze
  PITCH_APPLICATION_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-08-31').freeze

  PITCH_VOTING_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-12').freeze
  PITCH_VOTING_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-22').freeze

  SPONSORSHIP_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-03-01').freeze
  SPONSORSHIP_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-09').freeze

  AMBASSADOR_APPLICATION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-07-01').freeze
  AMBASSADOR_APPLICATION_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-08-11').freeze

  class << self
    def cfp_open?
      Time.zone.now > SUBMISSION_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < SUBMISSION_CLOSE_DATE.at_end_of_day
    end

    def voting_open?
      Time.zone.now > VOTING_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < VOTING_CLOSE_DATE.at_end_of_day
    end

    def registration_open?
      Time.zone.now > REGISTRATION_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < WEEK_END_DATE.at_end_of_day
    end

    def pitch_application_open?
      Time.zone.now > PITCH_APPLICATION_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < PITCH_APPLICATION_CLOSE_DATE.at_end_of_day
    end

    def pitch_voting_open?
      Time.zone.now > PITCH_VOTING_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < PITCH_VOTING_CLOSE_DATE.at_end_of_day
    end

    def sponsorship_open?
      Time.zone.now > SPONSORSHIP_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < SPONSORSHIP_CLOSE_DATE.at_end_of_day
    end

    def ambassador_application_open?
      Time.zone.now > AMBASSADOR_APPLICATION_OPEN_DATE.at_beginning_of_day &&
        Time.zone.now < AMBASSADOR_APPLICATION_CLOSE_DATE.at_end_of_day
    end

    def in_week?
      Time.zone.now > WEEK_START_DATE.at_beginning_of_day &&
        Time.zone.now < WEEK_END_DATE.at_end_of_day
    end

    def active_cycles
      cycles = []
      cycles << CFP_CYCLE if cfp_open?
      cycles << VOTING_CYCLE if voting_open?
      cycles << REGISTRATION_CYCLE if registration_open?
      cycles << WEEK_CYCLE if in_week?
      cycles << PITCH_APPLICATION_CYCLE if pitch_application_open?
      cycles << PITCH_VOTING_CYCLE if pitch_voting_open?
      cycles << SPONSORSHIP_CYCLE if pitch_application_open?
      cycles << AMBASSADOR_APPLICATION_CYCLE if ambassador_application_open?
      cycles << SPONSORSHIP_CYCLE if sponsorship_open?
      cycles
    end
  end
end
