class FeedEntryChangeNameToTitle < ActiveRecord::Migration
  def up
    remove_column :feed_entries, :name
    add_column :feed_entries, :title, :string
  end

  def down
    remove_column :feed_entries, :title
    add_column :feed_entries, :name, :string
  end
end
