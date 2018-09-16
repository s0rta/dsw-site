module ApplicationHelper

  def process_with_liquid(content)
    context = {
      'submission_open_date' =>
        AnnualSchedule
          .current
          .cfp_open_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_beginning_of_day,
      'submission_close_date' =>
        AnnualSchedule
          .current
          .cfp_close_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_end_of_day,
      'voting_open_date' =>
        AnnualSchedule
          .current
          .voting_open_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_beginning_of_day,
      'voting_close_date' =>
        AnnualSchedule
          .current
          .voting_close_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_end_of_day,
      'registration_open_date' =>
        AnnualSchedule
          .current
          .registration_open_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_beginning_of_day,
      'week_start_date' =>
        AnnualSchedule
          .current
          .week_start_at
          .in_time_zone(ActiveSupport::TimeZone['America/Denver'])
          .at_beginning_of_day,
      'current_date' => DateTime.now
    }
    template = Liquid::Template.parse(content)
    template.render(context)
  end

  def process_with_pipeline(content)
    context = {
      asset_root: '/images/icons'
    }
    pipeline = HTML::Pipeline.new(
      [
        HTML::Pipeline::MarkdownFilter,
        HTML::Pipeline::EmojiFilter,
        HTML::Pipeline::SanitizationFilter,
        HTML::Pipeline::AutolinkFilter
      ],
      context
    )
    result = pipeline.call content
    result[:output].html_safe
  end

  def current_year
    Date.today.year
  end

  def previous_year
    Date.today.year - 1
  end

  def most_recent_past_year
    if AnnualSchedule.post_week?
      current_year
    else
      previous_year
    end
  end

  def time_remaining_to_deadline(deadline_date)
    days = ((deadline_date.at_end_of_day - Time.zone.now) / 1.day)
    full_days = days.floor
    hours = (days - full_days) * 24
    full_hours = hours.floor
    minutes = (hours - full_hours) * 60
    full_minutes = minutes.floor
    "#{full_days} : #{full_hours.to_s.rjust(2, '0')} : #{full_minutes.to_s.rjust(2, '0')}"
  end

  def tracks_for_select
    Track.submittable.in_display_order.map { |t| [ t.name, t.id ] }
  end

  def clusters_for_select
    Cluster.in_display_order.map { |c| [ c.name, c.id ] }
  end

  def age_ranges_for_select
    Registration::AGE_RANGES
  end

  def primary_roles_for_select
    Registration::PRIMARY_ROLES
  end

  def basecamp_sessions
    Submission
      .for_current_year
      .for_schedule
      .joins(:track)
      .where(tracks: { name: 'Basecamp' })
  end

  def sponsorships_by_level
    @sponsorships_by_level ||= Sponsorship
                               .for_current_year
                               .for_sponsors_page
                               .alphabetical
                               .includes(:track, submission: :track)
                               .group_by(&:level)
  end

  def ambassador_host_company_sponsorships
    @ambassador_host_company_sponsorships ||= Sponsorship
                                              .for_current_year
                                              .where(level: Sponsorship::AMBASSADOR_HOST_LEVEL)
                                              .alphabetical
                                              .includes(:track, submission: :track)
  end

  def ambassador_sponsorships
    @ambassador_sponsorships ||= Sponsorship
                                 .for_current_year
                                 .where(level: Sponsorship::AMBASSADOR_SPONSOR_LEVEL)
                                 .alphabetical
                                 .includes(:track, submission: :track)
  end

  def ambassador_partners
    @ambassador_partners ||= Sponsorship
                             .for_current_year
                             .where(level: Sponsorship::AMBASSADOR_PARTNER_LEVEL)
                             .alphabetical
                             .includes(:track, submission: :track)
  end

  def footer_sponsors
    @footer_sponsors ||= Sponsorship.for_current_year.title.alphabetical
  end

  def podcast_sponsorships
    @podcast_sponsorships ||= Sponsorship
                              .for_current_year
                              .where(level: Sponsorship::PODCAST_LEVEL)
                              .alphabetical
                              .includes(:track, submission: :track)
  end

  def pitch_sponsors
    @pitch_sponsors ||= Sponsorship
                        .for_current_year
                        .where(level: Sponsorship::PITCH_LEVEL)
                        .alphabetical
  end

  def field_guide_sponsors
    @field_guide_sponsors ||= Sponsorship
                              .for_current_year
                              .where(level: Sponsorship::FIELD_GUIDE_LEVEL)
                              .alphabetical
  end

  def helpscout_articles_for_category(category_name)
    Helpscout::Article.for_category(category_name)
  end
end
