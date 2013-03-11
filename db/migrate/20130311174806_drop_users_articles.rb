class DropUsersArticles < ActiveRecord::Migration
  def up
    drop_table :users_articles
  end

  def down
    create_table :users_articles do |t|
      t.integer :user_id
      t.integer :article_id
    end
  end
end
