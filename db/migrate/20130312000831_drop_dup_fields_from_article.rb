class DropDupFieldsFromArticle < ActiveRecord::Migration
  change_table :articles do |t|
    t.remove :title
    t.remove :url
    t.remove :publish_date
  end
end
