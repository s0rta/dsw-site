class AddEventIdToSponsorships < ActiveRecord::Migration[5.1]
  def change
    add_reference :sponsorships, :submission, index: true, foreign_key: true
  end
end
