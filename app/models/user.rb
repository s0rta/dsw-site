class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :trackable,
    :validatable

  default_scope { order(Arel.sql("LOWER(name) ASC")) }

  validates :name, presence: true

  validates :team_priority,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10,
      allow_nil: true,
    }

  has_many :submissions, foreign_key: "submitter_id", dependent: :restrict_with_error
  has_many :votes, dependent: :destroy
  has_many :feedback, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :pitch_contest_votes, class_name: "PitchContest::Vote", dependent: :destroy
  has_many :authorships, dependent: :restrict_with_error
  has_many :articles, foreign_key: "submitter_id"

  has_and_belongs_to_many :chaired_tracks, class_name: "Track"
  has_and_belongs_to_many :companies
  has_many :venues, through: :companies

  mount_uploader :avatar, AvatarUploader
  process_in_background :avatar

  def self.on_team
    reorder("team_priority ASC, team_position DESC, name DESC")
      .where("team_position IS NOT NULL AND team_position <> ''")
  end

  def current_registration
    registrations.for_current_year.first
  end

  def registered?
    current_registration.present?
  end

  def flipper_id
    to_global_id.to_s
  end

  def initials
    name.split(" ").map { |n| n[0, 1] }.join
  end
end
