class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :feedzilla_id
      t.string :name
      t.string :feedzilla_url_name

      t.timestamps
    end
  end
end
