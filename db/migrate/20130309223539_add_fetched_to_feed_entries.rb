class AddFetchedToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :fetched, :boolean
  end
end
