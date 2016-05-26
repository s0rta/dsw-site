class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [ :linkedin ]

  default_scope { order('LOWER(name) ASC') }

  # attr_accessible :email,
  #                 :password,
  #                 :password_confirmation,
  #                 :remember_me,
  #                 :uid,
  #                 :provider,
  #                 :name,
  #                 :description

  # Add to ActiveAdmin as strong params
  # attr_accessible :email,
  #                 :password,
  #                 :password_confirmation,
  #                 :remember_me,
  #                 :uid,
  #                 :provider,
  #                 :name,
  #                 :description,
  #                 :is_admin, as: :admin

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true

  has_many :submissions, foreign_key: 'submitter_id'
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :registrations, dependent: :destroy

  def self.from_omniauth(auth_hash)
    User.where(uid: auth_hash[:uid], provider: auth_hash[:provider]).first_or_create do |u|
      u.name = auth_hash[:info][:name]
      u.email = auth_hash[:info][:email]
      u.password = Devise.friendly_token[0,20]
    end
  end

  def current_registration
    registrations.for_current_year.first
  end

  def registered?
    current_registration.present?
  end

end
