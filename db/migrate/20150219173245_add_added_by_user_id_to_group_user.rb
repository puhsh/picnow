class AddAddedByUserIdToGroupUser < ActiveRecord::Migration
  def change
    add_column :group_users, :added_by_user_id, :integer
    add_index :group_users, :added_by_user_id
  end
end
