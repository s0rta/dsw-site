class AddShowAttendancePubliclyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :show_attendance_publicly, :boolean, default: true, null: false
  end
end
