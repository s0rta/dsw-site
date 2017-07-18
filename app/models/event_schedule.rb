module EventSchedule

  CYCLES = %w(cfp voting registration week).freeze

  SUBMISSION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-03-19').freeze
  SUBMISSION_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-04-21').freeze

  VOTING_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-10').freeze
  VOTING_CLOSE_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-05-29').freeze

  REGISTRATION_OPEN_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-07-20').freeze

  WEEK_START_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-25').freeze
  WEEK_END_DATE = ActiveSupport::TimeZone['America/Denver'].parse('2017-09-29').freeze

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

    def in_week?
      Time.zone.now > WEEK_START_DATE.at_beginning_of_day &&
        Time.zone.now < WEEK_END_DATE.at_end_of_day
    end

    def active_cycles
      cycles = []
      cycles << :cfp if cfp_open?
      cycles << :voting if voting_open?
      cycles << :registration if registration_open?
      cycles << :week if in_week?
      cycles
    end
  end
end
