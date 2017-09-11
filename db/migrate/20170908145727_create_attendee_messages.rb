class CreateAttendeeMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :attendee_messages do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.references :submission, foreign_key: true, null: false
      t.datetime :sent_at

      t.timestamps
    end
  end
end
