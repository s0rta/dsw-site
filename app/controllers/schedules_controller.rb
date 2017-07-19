class SchedulesController < ApplicationController

  respond_to :html
  respond_to :json, only: :index

  before_action :ensure_registered!, only: [ :my_schedule, :create, :destroy ]
  before_action :authenticate_user!, only: [ :my_schedule, :create, :destroy ]

  def index
    @sessions = Submission.
                for_current_year.
                for_schedule.
                order(:start_day).
                includes(:venue, :submitter, :track)
    respond_to do |format|
      format.json do
        respond_with @sessions
      end
      format.html do
        redirect_to schedules_by_day_path(request.query_parameters)
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
                   includes(:venue, :submitter, :track)
    respond_with @sessions
  end

  def show
    @session = Submission.
               for_current_year.
               for_schedule.
               where(id: params[:id].to_i).
               order(:start_day).
               includes(:venue, :submitter, :track, comments: :user).
               first!
  end

  def my_schedule
    @my_schedule = true
    @sessions = current_registration.
                submissions.
                for_current_year.
                for_schedule.
                includes(:venue, :submitter, :track)
    render action: :index
  end

  def feed
    registration = Registration.where(calendar_token: params[:id]).first!
    @sessions = registration.
                submissions.for_current_year.
                for_schedule.
                includes(:venue, :submitter, :track)
    respond_to do |format|
      format.ics do
        calendar = Icalendar::Calendar.new
        @sessions.each do |submission|
          event_start = submission.start_datetime
          event_end = submission.end_datetime
          tzid = submission.start_datetime.time_zone.tzinfo.identifier
          tz = TZInfo::Timezone.get(tzid)
          timezone = tz.ical_timezone(event_start)
          calendar.add_timezone(timezone)
          event = Icalendar::Event.new
          event.dtstart = Icalendar::Values::DateTime.new(event_start, 'tzid' => tzid)
          event.dtend = Icalendar::Values::DateTime.new(event_end, 'tzid' => tzid)
          event.summary = submission.title
          event.description = "#{submission.description}\n\nMore details: #{schedule_url(id: submission.id)}"
          event.location = submission.ical_location
          event.ip_class = 'PUBLIC'
          event.created = submission.created_at
          event.last_modified = submission.updated_at
          event.uid = event.url = schedule_url(id: submission.id)
          calendar.add_event(event)
        end
        calendar.publish
        render text: calendar.to_ical
      end
    end
  end

  def create
    @session = Submission.for_schedule.
      where(id: params[:id].to_i).
      includes(:submitter, :track, comments: :user).
      first!
    current_registration.submissions << @session unless current_registration.submissions.include?(@session)
    render action: :show
  end

  def destroy
    @session = Submission.for_schedule.
      where(id: params[:id].to_i).
      includes(:submitter, :track, comments: :user).
      first!
    current_registration.session_registrations.where(submission_id: @session.id).destroy_all
    render action: :show
  end

end
