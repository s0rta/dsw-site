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
                  :theme_id,
                  :venue_id

  attr_accessible :start_day,
                  :end_day,
                  :description,
                  :format,
                  :location,
                  :notes,
                  :time_range,
                  :title,
                  :track_id,
                  :contact_email,
                  :estimated_size,
                  :theme_id,
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

  DAYS =  [ 'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Weekend before',
            'Weekend after' ]

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
  belongs_to :theme
  belongs_to :venue

  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :contact_email, presence: true
  validates :format, inclusion: {   in: FORMATS,
                                    allow_blank: true }
  validates :start_day, inclusion: {  in: DAYS,
                                allow_blank: true }
  validates :end_day, inclusion: {  in: DAYS,
                                allow_blank: true }
  validates :time_range, inclusion: { in: TIME_RANGES,
                                      allow_blank: true }
  validates :start_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  validates :end_hour, numericality: { greater_than_or_equal_to: 0, less_than: 24 }
  validates :track_id, presence: true
  validates :location, length: { maximum: 255 }

  after_create :notify_track_chairs
  after_create :send_confirmation_notice

  def to_param
    "#{self.id}-#{self.title.parameterize}"
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

  after_commit :propagate_to_zerista_asynchronously

  def self.propagate_to_zerista
    where(is_confirmed: true).each(&:propagate_to_zerista)
  end

end
