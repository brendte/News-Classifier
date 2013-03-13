class AddEuclideanLengthToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :euclidean_length, :float
  end
end
