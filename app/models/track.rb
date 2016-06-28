class Track < ActiveRecord::Base

  # Add to ActiveAdmin as strong params
  # attr_accessible :name,
  #                 :icon,
  #                 :email_alias

  validates :name, presence: true

  has_many :submissions, dependent: :destroy
  has_and_belongs_to_many :chairs, class_name: 'User'

  def self.in_display_order
    order('display_order ASC, name ASC')
  end

  def self.submittable
    where(is_submittable: true)
  end
end
