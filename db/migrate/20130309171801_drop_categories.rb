class DropCategories < ActiveRecord::Migration
  def up
   drop_table :categories
  end

  def down
    create_table :categories do |t|
      t.integer :feedzilla_id
      t.string :name
      t.string :feedzilla_url_name

      t.timestamps
    end
  end
end
