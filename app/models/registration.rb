class Registration < ApplicationRecord

  AGE_RANGES = [
    'Under 18 years old',
    '18-24 years old',
    '25-34 years old',
    '35-44 years old',
    '45-54 years old',
    '55-64 years old',
    '65-74 years old',
    '75 years or older'
  ].freeze

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
