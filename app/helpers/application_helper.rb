module ApplicationHelper
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

  def time_remaining_to_deadline(deadline_str)
    Time.use_zone('Mountain Time (US & Canada)') do
      deadline_date =  (Time.zone.parse(deadline_str) + 1.day).at_midnight
      days = ((deadline_date - Time.zone.now) / 1.day)
      full_days = days.floor
      hours = (days - full_days) * 24
      full_hours = hours.floor
      minutes = (hours - full_hours) * 60
      full_minutes = minutes.floor
      "#{full_days} : #{full_hours.to_s.rjust(2, "0")} : #{full_minutes.to_s.rjust(2, "0")}"
    end
  end

  def tracks_for_select
    Track.submittable.in_display_order.map { |t| [ t.name, t.id ] }
  end

  def volunteer_shifts_for_select
    VolunteerShift.for_select
  end

end
