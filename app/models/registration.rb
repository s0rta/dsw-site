class Registration < ActiveRecord::Base

  belongs_to :user
  has_many :session_registrations, dependent: :destroy
  has_many :submissions, through: :session_registrations

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

  after_create :subscribe_to_list

  def subscribe_to_list
    ListSubscriptionJob.perform(contact_email)
  end

  after_create :send_confirmation_email

  def send_confirmation_email
    ConfirmRegistrationJob.perform(self)
  end

  def self.for_current_year
    where(year: Date.today.year)
  end

end
