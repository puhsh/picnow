class AddGroupIdToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :group_id, :integer

    add_index :invites, :group_id
  end
end
