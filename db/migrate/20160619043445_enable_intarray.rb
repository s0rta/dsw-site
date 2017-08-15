class EnableIntarray < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'intarray' unless extension_enabled?('intarray')
  end
end
