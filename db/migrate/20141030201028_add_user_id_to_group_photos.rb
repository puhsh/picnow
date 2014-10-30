class AddUserIdToGroupPhotos < ActiveRecord::Migration
  def change
    add_column :group_photos, :user_id, :integer, after: :photo_id
    add_index :group_photos, :user_id

    Photo.find_each do |photo|
      photo.group_photos.update_all(user_id: photo.user_id)
    end
  end
end
