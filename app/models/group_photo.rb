class GroupPhoto < ActiveRecord::Base
  include Eventable

  # Relations
  belongs_to :group
  belongs_to :photo
  belongs_to :user
  has_one :notification, as: :trigger

  # Callbacks
  before_create :zero_out_points
  
  # Validations
  
  # Scopes

  # Methods

  protected

  # Protected: Zero outs points if there is no one else in the group o it isn't the first photo or the group has notifications
  #
  # Returns a 0 if the value is adjusted
  def zero_out_points
    if (GroupUser.where(group_id: self.group_id).count == 1 && GroupPhoto.where(group_id: self.group_id).count != 0) || Notification.where(group_id: self.group_id, read: false, user_id: self.user_id, trigger_type: 'Photo').count != 0
      self.point_value = 0
    else
      self.point_value = self.point_value || 99
    end
  end
end
