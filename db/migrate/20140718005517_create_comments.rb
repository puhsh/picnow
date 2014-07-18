class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.string :content, null: false, default: ''
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :group_id
  end
end
