class CreatePublishings < ActiveRecord::Migration[5.2]
  def up
    create_table :publishings do |t|
      t.references :subject, polymorphic: true, null: false
      t.timestamp :effective_at, index: true
      t.timestamps
    end

    Article.where.not(published_at: nil).each do |a|
      publishing = a.publishing || a.build_publishing
      publishing.update(effective_at: a.published_at)
    end

    remove_column :articles, :published_at, :timestamp
  end

  def down
    add_column :articles, :published_at, :timestamp
    Article.reset_column_information
    Publishing.find_each do |p|
      p.article.update_attribute(:published_at, p.effective_at)
    end
    drop_table :publishings
  end
end
