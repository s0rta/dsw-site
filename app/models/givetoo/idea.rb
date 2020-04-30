class Givetoo::Idea < ApplicationRecord
  KINDS = %w[event grant program website]

  belongs_to :user

  validates :title,
    :description,
    presence: true

  validates :kind, inclusion: {in: KINDS}
end
