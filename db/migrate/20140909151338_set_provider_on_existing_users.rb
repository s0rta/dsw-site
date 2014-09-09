class SetProviderOnExistingUsers < ActiveRecord::Migration
  def up
    user_klass = Class.new(ActiveRecord::Base) do
      self.table_name = 'users'
    end
    user_klass.update_all provider: 'linkedin'
  end

  def down
    # No-op
  end
end
