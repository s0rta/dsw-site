class Cluster < ApplicationRecord
  validates :name, presence: true
  has_many :submissions, dependent: :nullify

  def self.in_display_order
    order('name DESC')
  end

  def self.active
    where(is_active: true)
  end

  def self.template_list_data
    select("name AS title, description, is_active")
      .in_display_order
      .active
  end
end
