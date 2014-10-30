class RemoveGroupIdFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :group_id
  end
end
