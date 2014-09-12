class RemoveUniqueIndexFromUsersPhone < ActiveRecord::Migration
  def change
    remove_index :users, :phone_number
    add_index :users, :phone_number, unique: false
  end
end
