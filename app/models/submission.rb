class Submission < ActiveRecord::Base

  attr_accessible :day, :description, :format, :location, :notes, :time_range, :title, :track_id, :contact_email

  FORMATS = [ 'Presentation',
              'Panel',
              'Workshop',
              'Social event',
              'Something else entirely' ]
  DAYS =  [ 'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Weekend before',
            'Weekend after',
            'Not sure / don\'t care ' ]
  TIME_RANGES = [ 'Early morning',
                  'Breakfast',
                  'Morning',
                  'Lunch',
                  'Early afternoon',
                  'Afternoon',
                  'Happy hour',
                  'Evening',
                  'Late night',
                  'Not sure / don\'t care' ]

  belongs_to :submitter, class_name: 'User'
  belongs_to :track

  validates :title, presence: true
  validates :description, presence: true
  validates :contact_email, presence: true
  validates :format,  presence: true,
                      inclusion: { in: FORMATS }
  validates :day,  presence: true,
                      inclusion: { in: DAYS }
  validates :time_range,  presence: true,
                      inclusion: { in: TIME_RANGES }
end
