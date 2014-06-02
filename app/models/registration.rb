class Registration < ActiveRecord::Base

  belongs_to :user

  attr_accessible :contact_email,
                  :year,
                  :zip,
                  :company,
                  :gender,
                  :primary_role,
                  :track_id

  validates :user, presence: true
  validates :contact_email, presence: true

  after_initialize do
    self.year ||= Date.today.year
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

end
