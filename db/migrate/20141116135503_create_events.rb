class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :group_id
      t.json :payload
      t.timestamps
    end

    add_index :events, :group_id
  end
end
