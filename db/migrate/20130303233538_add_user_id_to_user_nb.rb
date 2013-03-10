class AddUserIdToUserNb < ActiveRecord::Migration
  def change
    add_column :user_nbs, :user_id, :integer
  end
end
