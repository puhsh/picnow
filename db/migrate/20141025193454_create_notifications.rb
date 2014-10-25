class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :read, default: false
      t.timestamps
    end

    add_index :notifications, :group_id
    add_index :notifications, :user_id
  end
end
