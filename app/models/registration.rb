class Registration < ActiveRecord::Base

  belongs_to :user
  has_many :session_registrations, dependent: :destroy
  has_many :submissions, through: :session_registrations

  validates :user,
            :age_range,
            :primary_role, presence: true

  after_initialize do
    self.year ||= Date.today.year
    self.calendar_token ||= SecureRandom.hex(25)
  end

  after_commit :subscribe_to_list

  def subscribe_to_list
    registered_years = user.registrations.map(&:year).sort.map(&:to_s)
    ListSubscriptionJob.perform_async(user.email,
                                registered_years: registered_years)
  end

  after_create :send_confirmation_email

  def send_confirmation_email
    ConfirmRegistrationJob.perform_async(self)
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

end
