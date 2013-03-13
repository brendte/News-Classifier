class CreateArticlesUsers < ActiveRecord::Migration
  def up
    create_table :articles_users do |t|
      t.integer :user_id
      t.integer :article_id
    end
  end

  def down
    drop_table :articles_users
  end
end
