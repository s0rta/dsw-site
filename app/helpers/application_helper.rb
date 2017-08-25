module ApplicationHelper

  def process_with_liquid(content)
    context = {
      'submission_close_date' => EventSchedule::SUBMISSION_CLOSE_DATE,
      'voting_close_date' => EventSchedule::VOTING_CLOSE_DATE,
      'current_date' => DateTime.now
    }
    template = Liquid::Template.parse(content)
    template.render(context)
  end

  def process_with_pipeline(content)
    context = {
      asset_root: "/images/icons"
    }
    pipeline = HTML::Pipeline.new([
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::AutolinkFilter
    ], context)
    result = pipeline.call content
    result[:output].html_safe
  end

  def current_year
    Date.today.year
  end

  def time_remaining_to_deadline(deadline_date)
    days = ((deadline_date.at_end_of_day - Time.zone.now) / 1.day)
    full_days = days.floor
    hours = (days - full_days) * 24
    full_hours = hours.floor
    minutes = (hours - full_hours) * 60
    full_minutes = minutes.floor
    "#{full_days} : #{full_hours.to_s.rjust(2, "0")} : #{full_minutes.to_s.rjust(2, "0")}"
  end

  def tracks_for_select
    Track.submittable.in_display_order.map { |t| [ t.name, t.id ] }
  end

  def clusters_for_select
    Cluster.in_display_order.map { |c| [ c.name, c.id ] }
  end

  def volunteer_shifts_for_select
    VolunteerShift.for_select
  end

  def age_ranges_for_select
    Registration::AGE_RANGES
  end

  def mentor_sessions
    [
      # { title: 'Adam Schlegel, EatDenver',
      #   timeslot: 'Monday 9/12: 9-11am',
      #   signup_url: 'http://slottd.com/events/tv98le5rg9/slots' }
    ]
  end

  def group_mentor_sessions
    [
      # { title: 'HomeAdvisor',
      #   timeslot: 'Monday 9/12: 2:30-4pm',
      #   signup_url: 'http://slottd.com/events/f9256ejikx/slots' }
    ]
  end

  def basecamp_sessions
    Submission.
      for_current_year.
      for_schedule.
      joins(:track).
      where(tracks: { name: 'Basecamp' })
  end
end
