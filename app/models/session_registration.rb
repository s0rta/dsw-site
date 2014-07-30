class SessionRegistration < ActiveRecord::Base
  belongs_to :registration
  belongs_to :submission
end
