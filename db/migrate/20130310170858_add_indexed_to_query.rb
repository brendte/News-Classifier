class AddIndexedToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :indexed, :boolean
  end
end
