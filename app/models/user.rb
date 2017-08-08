class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :trackable,
         :validatable

  default_scope { order('LOWER(name) ASC') }

  validates :name, presence: true

  has_many :submissions, foreign_key: 'submitter_id'
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :volunteerships, dependent: :destroy

  def current_registration
    registrations.for_current_year.first
  end

  def registered?
    current_registration.present?
  end

  def current_volunteership
    volunteerships.for_current_year.first
  end

  def volunteered?
    current_volunteership.present?
  end
end
