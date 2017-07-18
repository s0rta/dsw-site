# frozen_string_literal: true

class CreateHomepageCtas < ActiveRecord::Migration
  def change
    create_table :homepage_ctas do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.string :body, null: false
      t.string :link_text, null: false
      t.string :link_href, null: false
      t.string :relevant_to_cycle
      t.boolean :is_active, default: true, null: false
      t.timestamps null: false
    end
  end
end
