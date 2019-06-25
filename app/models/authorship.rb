class Authorship < ApplicationRecord
  belongs_to :article
  belongs_to :user
end
