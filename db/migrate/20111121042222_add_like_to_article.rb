class AddLikeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :like, :boolean
  end
end
