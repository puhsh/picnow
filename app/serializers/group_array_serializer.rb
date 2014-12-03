class GroupArraySerializer < ActiveModel::Serializer
 attributes :id, :name, :last_photo_sent_at, :created_at, :updated_at, :unread_notifications_count, :admin_id

  def unread_notifications_count
    if @scope
      object.notifications.where(read: false, user_id: @scope.id).count  
    else
      0
    end
  end
end
