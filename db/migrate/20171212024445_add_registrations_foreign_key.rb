class AddRegistrationsForeignKey < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :registrations, :users
  end
end
