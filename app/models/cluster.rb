class Cluster < ActiveRecord::Base
  validates :name, presence: true
  has_many :submissions, dependent: :nullify
end
