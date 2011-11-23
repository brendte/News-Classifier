class CreateUserNbs < ActiveRecord::Migration
  def change
    create_table :user_nbs do |t|
      t.string :user
      t.binary :nb_obj

      t.timestamps
    end
  end
end
