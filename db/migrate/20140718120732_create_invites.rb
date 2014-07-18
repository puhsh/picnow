class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.string :to, null: false, default: ""
      t.integer :joined_user_id
      t.timestamps
    end

    add_index :invites, :user_id
    add_index :invites, :joined_user_id
  end
end
