class AddSimilarIdsToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :cached_similar_item_ids, :integer, array: true, default: []
  end
end
