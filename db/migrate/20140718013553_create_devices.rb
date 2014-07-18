class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :brand
      t.integer :user_id
      t.string :token
      t.timestamps
    end

    add_index :devices, :brand
    add_index :devices, :user_id
  end
end
