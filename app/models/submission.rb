class Submission < ActiveRecord::Base

  has_paper_trail

  attr_accessible :start_day,
                  :description,
                  :format,
                  :location,
                  :notes,
                  :time_range,
                  :title,
                  :track_id,
                  :contact_email,
                  :estimated_size,
                  :venue_id

  attr_accessible :start_day,
                  :end_day,
                  :year,
                  :description,
                  :format,
                  :location,
                  :notes,
                  :time_range,
                  :title,
                  :track_id,
                  :contact_email,
                  :estimated_size,
                  :is_public,
                  :is_confirmed,
                  :venue_id,
                  :budget_needed,
                  :volunteers_needed,
                  :start_hour,
                  :end_hour,
                  :submitter_id, as: :admin

  FORMATS = [ 'Presentation',
              'Panel',
              'Workshop',
              'Social event' ]

  DAYS = { 1 => 'Weekend before',
           2 => 'Monday',
           3 => 'Tuesday',
           4 => 'Wednesday',
           5 => 'Thursday',
           6 => 'Friday',
           7 => 'Weekend after' }

  TIME_RANGES = [ 'Early morning',
                  'Breakfast',
                  'Morning',
                  'Lunch',
                  'Early afternoon',
                  'Afternoon',
                  'Happy hour',
                  'Evening',
                  'Late night' ]

  belongs_to :submitter, class_name: 'User'
  belongs_to :track
  belongs_to :venue

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :session_registrations, dependent: :destroy
  has_many :user_registrations, through: :session_registrations,
                                class_name: 'Registration',
                                source: :registration
  has_many :registrants, through: :user_registrations,
                         class_name: 'User',
                         source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :contact_email, presence: true
  validates :format, inclusion: {   in: FORMATS,
                                    allow_blank: true }
  # validates :start_day, inclusion: {  in: DAYS,
                                # allow_blank: true }
  # validates :end_day, inclusion: {  in: DAYS,
                                # allow_blank: true }
  # validates :time_range, inclusion: { in: TIME_RANGES,
                                      # allow_blank: true }
  # validates :start_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  # validates :end_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  validates :track_id, presence: true
  validates :location, length: { maximum: 255 }

  after_create :notify_track_chairs
  after_create :send_confirmation_notice

  after_initialize do
    self.year ||= Date.today.year
  end


  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

  def self.for_previous_years
    where('year < ? ', Date.today.year)
  end

  def self.public
    where(state: %w(open_for_voting accepted confirmed))
  end

  def self.confirmed
    where(state: 'confirmed')
  end

  def self.for_schedule
    confirmed.where('start_day IS NOT NULL AND end_day IS NOT NULL')
  end

  def notify_track_chairs
    self.track.chairs.each do |chair|
      NotificationsMailer.notify_of_new_submission(chair, self).deliver
    end
  end

  def send_confirmation_notice
    NotificationsMailer.confirm_new_submission(self).deliver
  end

  def propagate_to_zerista
    ZeristaReplicator.new(self).replicate!
  end

  def propagate_to_zerista_asynchronously
    ZeristaPropagationJob.new.async.perform(self.id)
  end

  after_commit :propagate_to_zerista_asynchronously, if: :zerista_enabled?

  def self.propagate_to_zerista
    where(is_confirmed: true).each(&:propagate_to_zerista)
  end

  def zerista_enabled?
    ENV['ZERISTA_ENABLED'] == 'true'
  end

  # State machine
  include SimpleStates

  states  :created,
          :on_hold,
          :open_for_voting,
          :accepted,
          :confirmed,
          :rejected

  event :place_on_hold,       to: :on_hold
  event :open_for_voting,     to: :open_for_voting
  event :accept,              from: :open_for_voting,   to: :accepted
  event :reject,              to: :rejected
  event :confirm,             from: :accepted,          to: :confirmed

  # Helpers

  def has_time_set?
    start_day &&
    start_hour &&
    end_day &&
    end_hour
  end

  def human_location_name
    if venue
      venue.name
    else
      'Location TBA'
    end
  end

  def human_start_day
    DAYS[start_day]
  end

  def human_end_day
    DAYS[end_day]
  end

end
