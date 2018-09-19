class Ambassador < ApplicationRecord

  include YearScoped

  validates :first_name,
            :last_name,
            :company,
            :title,
            :location,
            presence: true
end
