class Article < ApplicationRecord
  validates :title,
    presence: true

  validates :body,
    length: {maximum: 150},
    presence: true

  has_and_belongs_to_many :tracks

  belongs_to :author, class_name: "User"
end
