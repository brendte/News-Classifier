class AddRoutedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :routed, :boolean
  end
end
