class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_photo_sent_at, :created_at, :updated_at, :unread_notifications_count
  has_many :photos

  def unread_notifications_count
    object.notifications.where(read: false).count
  end
end
