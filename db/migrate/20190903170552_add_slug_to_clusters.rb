class AddSlugToClusters < ActiveRecord::Migration[5.2]
  def up
    add_column :clusters, :slug, :string
    Cluster.reset_column_information
    Cluster.find_each do |c|
      c.update_attribute :slug, c.name.parameterize
    end
  end

  def down
    remove_column :clusters, :slug
  end
end
