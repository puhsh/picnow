class AddDeletedAtToGroupUser < ActiveRecord::Migration
  def change
    add_column :group_users, :deleted_at, :datetime
  end
end
