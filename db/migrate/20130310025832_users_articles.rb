class UsersArticles < ActiveRecord::Migration
  def change
    create_table :users_articles do |t|
      t.integer :user_id
      t.integer :article_id
    end
  end
end
