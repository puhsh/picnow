class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_photo_sent_at, :created_at, :updated_at, :unread_notifications_count
  has_many :photos

  def unread_notifications_count
    0
  end
end
