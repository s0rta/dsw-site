class AddContactEmailToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :contact_email, :string
  end
end
