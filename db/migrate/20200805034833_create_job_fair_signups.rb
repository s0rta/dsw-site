class CreateJobFairSignups < ActiveRecord::Migration[6.0]
  def change
    create_table :job_fair_signups do |t|
      t.references :company, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.boolean :actively_hiring, default: true, null: false
      t.integer :number_open_positions
      t.integer :number_hiring_next_12_months
      t.text :industry_category
      t.text :organization_size
      t.text :covid_impact
      t.text :contact_email
      t.text :notes
      t.integer :year
      t.timestamps
    end
  end
end
