class CreateGroupPhotos < ActiveRecord::Migration
  def change
    create_table :group_photos do |t|
      t.integer :group_id
      t.integer :photo_id
      t.integer :point_value, default: 99
      t.timestamps
    end

    add_index :group_photos, :group_id
    add_index :group_photos, :photo_id

    Photo.find_each do |photo|
      GroupPhoto.create(group_id: photo.group_id, photo_id: photo.id)
    end
  end
end
