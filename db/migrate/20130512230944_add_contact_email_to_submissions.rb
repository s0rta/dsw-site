class AddContactEmailToSubmissions < ActiveRecord::Migration[4.2]
  def change
    add_column :submissions, :contact_email, :string
  end
end
