class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end

    add_index :photos, :user_id
    add_index :photos, :group_id
  end
end
