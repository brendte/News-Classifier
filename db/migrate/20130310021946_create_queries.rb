class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :user_id
      t.string :query_term_list_id

      t.timestamps
    end
  end
end
