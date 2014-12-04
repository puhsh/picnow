class RemoveDeletedAtColumns < ActiveRecord::Migration
  def change
    remove_column :groups, :deleted_at
    remove_column :group_users, :deleted_at
  end
end
