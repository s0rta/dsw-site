class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :submission, touch: true

  def self.for_current_year
    joins(:submission).merge(Submission.for_current_year)
  end

end
