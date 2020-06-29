class CreateCfpExtensions < ActiveRecord::Migration[6.0]
  def change
    create_table :cfp_extensions do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.date :expires_at, null: false

      t.timestamps
    end
  end
end
