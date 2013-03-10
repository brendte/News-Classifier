class AddEuclideanLengthToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :euclidean_length, :float
  end
end
