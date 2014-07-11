class RenameLastPhotoReceivedAt < ActiveRecord::Migration
  def change
    rename_column :groups, :last_photo_received_at, :last_photo_sent_at
  end
end
