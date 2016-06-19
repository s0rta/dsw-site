class EnableIntarray < ActiveRecord::Migration
  def change
    enable_extension 'intarray' unless extension_enabled?('intarray')
  end
end
