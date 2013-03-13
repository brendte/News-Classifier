class RemoveLikeFromArticle < ActiveRecord::Migration
  change_table :articles do |t|
    t.remove :like
  end
end
