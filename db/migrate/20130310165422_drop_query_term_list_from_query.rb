class DropQueryTermListFromQuery < ActiveRecord::Migration
  def up
    remove_column :queries, :query_term_list_id
    add_column :queries, :body, :text
  end

  def down
    remove_column :queries, :body
    add_column :queries, :query_term_list_id, :string
  end
end
