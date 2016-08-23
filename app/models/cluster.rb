class Cluster < ActiveRecord::Base
  validates :name, presence: true
  has_many :submissions, dependent: :nullify

  def self.in_display_order
    order('name DESC')
  end
end
