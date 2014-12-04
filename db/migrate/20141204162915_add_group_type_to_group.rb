class AddGroupTypeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :group_type, :string, default: :private_group
    add_index :groups, :group_type
  end
end
