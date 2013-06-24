class Submission < ActiveRecord::Base

  attr_accessible :day,
                  :description,
                  :format,
                  :location,
                  :notes,
                  :time_range,
                  :title,
                  :track_id,
                  :contact_email,
                  :estimated_size,
                  :theme_id

  attr_accessible :day,
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

  validates :title, presence: true
  validates :description, presence: true
  validates :contact_email, presence: true
  validates :format,  presence: true,
                      inclusion: { in: FORMATS,
                                   allow_nil: true }
  validates :day,  presence: true,
                      inclusion: { in: DAYS,
                                   allow_nil: true }
  validates :time_range,  presence: true,
                      inclusion: { in: TIME_RANGES,
                                   allow_nil: true }
  validates :track_id, presence: true

  after_create :notify_track_chairs

  def notify_track_chairs
    self.track.chairs.each do |chair|
      NotificationsMailer.notify_of_new_submission(chair, self).deliver
    end
  end

end
