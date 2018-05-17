class Feedback < ApplicationRecord

  RATINGS = {
    '5' => 'Outstanding',
    '4' => 'Great',
    '3' => 'Good',
    '2' => 'Fair',
    '1' => 'Poor'
  }.freeze

  validates :rating,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  belongs_to :user
  belongs_to :submission

  def human_rating
    RATINGS[rating.to_s]
  end
end
