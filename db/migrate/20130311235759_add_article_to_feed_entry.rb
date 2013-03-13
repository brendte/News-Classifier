class AddArticleToFeedEntry < ActiveRecord::Migration
  def change
    add_column :feed_entries, :article_id, :integer
  end
end
