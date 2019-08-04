class CreateRegistrationEthnicities < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_ethnicities do |t|
      t.references :registration, foreign_key: true
      t.references :ethnicity, foreign_key: true

      t.timestamps
    end
  end
end
