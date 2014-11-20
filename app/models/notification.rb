class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :trigger, polymorphic: true

  # Public: Marks all notifications as read
  #
  # Returns the updated notifications
  def mark_all_as_read!(user, group = nil)
    if group
      Notification.where(user_id: user.id, group_id: group.id).update_all(read: true)
    else
      Notification.where(user_id: user.id).update_all(read: true)
    end
  end
end
