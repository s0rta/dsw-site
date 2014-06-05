class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :submission, touch: true

  attr_accessible :body,
                  :user_id

  validates :body, presence: true
  validates :user_id, presence: true

  def self.for_current_year
    joins(:submission).merge(Submission.for_current_year)
  end

end
