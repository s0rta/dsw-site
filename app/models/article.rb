class Article < ApplicationRecord
  validates :title,
    presence: true

  validates :body,
    length: {maximum: 150},
    presence: true

  belongs_to :author, class_name: "User"
end
