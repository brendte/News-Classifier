class AddThresholdToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :threshold, :float
  end
end
