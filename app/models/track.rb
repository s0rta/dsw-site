class Track < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :submissions, dependent: :destroy
end
