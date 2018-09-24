class SessionRegistration < ApplicationRecord
  belongs_to :registration
  belongs_to :submission, counter_cache: :registrant_count
end
