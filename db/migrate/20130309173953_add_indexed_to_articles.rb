class AddIndexedToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :indexed, :boolean
  end

  def down
    remove_column :articles, :indexed
  end
end
