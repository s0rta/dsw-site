class SessionRegistration < ApplicationRecord
  belongs_to :registration
  belongs_to :submission
end
