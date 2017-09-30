class SchedulesController < ApplicationController

  respond_to :html
  respond_to :json, only: :index
  respond_to :ics, only: :index

  before_action :ensure_registered!, only: %i(create destroy)
  before_action :authenticate_user!, only: %i(create destroy)

  def index
    @sessions = Submission.
                for_current_year.
                for_schedule.
                order(:start_day).
                includes(:venue, :submitter, :track, :cluster, sponsorship: :track)
    respond_to do |format|
      format.json do
        respond_with @sessions
      end
      format.html do
        redirect_to schedules_by_day_path({ start_day:  current_day_or_default }.merge(request.query_parameters))
      end
    end
  end

  def by_day
    @day_index = Submission::DAYS.invert[params[:start_day].titleize]
    @submissions = Submission.
                   for_current_year.
                   for_schedule.
                   for_start_day(params[:start_day]).
                   for_schedule_filter(params[:filter], current_user).
                   fulltext_search(params[:terms]).
                   order(:start_hour).
                   includes(:venue, :submitter, :track, :cluster, sponsorship: :track)
    respond_with @sessions
  end

  def show
    @session = Submission.
               for_current_year.
               for_schedule.
               where(id: params[:id].to_i).
               order(:start_day).
               includes(:venue, :submitter, :track, :cluster, sponsorship: :track).
               first!

    @related_sessions = @session.
                        cached_similar_items.
                        for_current_year.
                        for_schedule.
                        limit(3).
                        includes(:venue, :track, :cluster, sponsorship: :track)
  end

  def feed
    registration = Registration.where(calendar_token: params[:id]).includes(:user).first!
    @sessions = registration.
                submissions.for_current_year.
                for_schedule.
                includes(:venue, :submitter, :track, :cluster, sponsorship: :track)
    respond_to do |format|
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.x_wr_calname = "#{registration.user.name}'s Denver Startup Week #{Date.today.year} Schedule"
        @sessions.each do |submission|
          event_start = submission.start_datetime
          event_end = submission.end_datetime
          tzid = submission.start_datetime.time_zone.tzinfo.identifier
          tz = TZInfo::Timezone.get(tzid)
          timezone = tz.ical_timezone(event_start)
          calendar.add_timezone(timezone)
          event = Icalendar::Event.new.tap do |e|
            e.dtstart       = Icalendar::Values::DateTime.new(event_start, 'tzid' => tzid)
            e.dtend         = Icalendar::Values::DateTime.new(event_end, 'tzid' => tzid)
            e.summary       = submission.full_title
            e.description   = "#{submission.description}\n\nMore details: #{schedule_url(submission)}"
            e.location      = submission.ical_location
            e.ip_class      = 'PUBLIC'
            e.created       = submission.created_at
            e.last_modified = submission.updated_at
            e.uid           = schedule_url(submission)
            e.url           = schedule_url(submission)
          end
          calendar.add_event event
        end
        calendar.publish
        render body: calendar.to_ical, content_type: 'text/calendar'
      end
    end
  end

  def create
    @session = Submission.
               for_schedule.
               where(id: params[:id].to_i).
               first!
    current_registration.submissions << @session unless current_registration.submissions.include?(@session)
    redirect_to schedule_path(@session)
  end

  def destroy
    @session = Submission.
               for_schedule.
               where(id: params[:id].to_i).
               first!
    current_registration.session_registrations.where(submission_id: @session.id).destroy_all
    redirect_to schedule_path(@session)
  end

  private

  def current_day_or_default
    if EventSchedule.in_week?
      zone = ActiveSupport::TimeZone['America/Denver']
      day_index = ((zone.now.at_beginning_of_day - EventSchedule::WEEK_START_DATE.at_beginning_of_day) / 1.day).ceil + 2
      Submission::DAYS[day_index].downcase
    else
      'monday'
    end
  end
end
