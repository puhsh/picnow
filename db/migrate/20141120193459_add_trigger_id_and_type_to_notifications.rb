class AddTriggerIdAndTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :trigger_id, :integer
    add_column :notifications, :trigger_type, :string

    add_index :notifications, :trigger_id
    add_index :notifications, :trigger_type
  end
end
