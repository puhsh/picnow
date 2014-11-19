class GroupPhoto < ActiveRecord::Base
  include Eventable

  # Relations
  belongs_to :group
  belongs_to :photo
  belongs_to :user

  # Callbacks
  before_save :zero_out_points
  
  # Validations
  
  # Scopes

  # Methods

  protected

  # Protected: Zero outs points if there is no one else in the group o it isn't the first photo or the group has notifications
  #
  # Returns a 0 if the value is adjusted
  def zero_out_points
    if !GroupUser.where(group_id: self.group_id).count > 1 || !GroupPhoto.where(group_id: self.group_id).exists? || !self.group.notifications.where(read: false, user_id: self.user_id).count == 0
      self.point_value = 0
    end
  end
end
