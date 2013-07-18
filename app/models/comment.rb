class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission
  attr_accessible :body,
                  :user_id

  validates :body, presence: true
  validates :user_id, presence: true
end
