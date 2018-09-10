class MentorSession < ApplicationRecord

  include YearScoped

  validates :title,
            :timeslot,
            presence: true

  validates :signup_url,
            presence: true,
            url: true

end
