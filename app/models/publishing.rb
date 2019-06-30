class Publishing < ApplicationRecord
  belongs_to :subject, polymorphic: true
end
