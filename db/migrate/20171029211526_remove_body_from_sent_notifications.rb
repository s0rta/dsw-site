class RemoveBodyFromSentNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :sent_notifications, :body, :text
  end
end
