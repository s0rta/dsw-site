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

  PRIMARY_ROLES = [
    'Accounting & Finance',
    'Contract & Freelance',
    'Customer Service/Success',
    'Data/Analytics',
    'Design',
    'Developer/Engineer',
    'Founder/Executive',
    'Government',
    'Health Care',
    'Hospitality',
    'Information Technology',
    'Manufacturing',
    'Non-profit',
    'Operations',
    'Product',
    'Recruiting & Human Resources',
    'Sales & Marketing',
    'Writing & Content',
    'Other'
  ].freeze

  belongs_to :user
  belongs_to :company, optional: true
  has_many :session_registrations, dependent: :destroy
  has_many :submissions, through: :session_registrations
  has_many :registration_attendee_goals, dependent: :destroy
  has_many :attendee_goals, through: :registration_attendee_goals

  validates :user,
            :age_range,
            :primary_role, presence: true

  validates :user_id, uniqueness: { scope: :year, message: 'may only register once per year' }
  validates :coc_acknowledgement, acceptance: true

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
    ConfirmRegistrationJob.perform_async(id)
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

  def company_name
    company.try(:name)
  end

  def company_name=(value)
    self.company = Company.where('LOWER(name) = LOWER(?)', value).first_or_initialize(name: value)
  end
end
