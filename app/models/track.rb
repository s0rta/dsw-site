class Track < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  has_many :submissions, dependent: :destroy
  has_and_belongs_to_many :chairs, class_name: 'User'

end
