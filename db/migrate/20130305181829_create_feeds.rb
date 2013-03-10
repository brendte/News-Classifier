class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :feed_url
      t.string :etag

      t.timestamps
    end
  end
end
