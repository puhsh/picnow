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

  # Protected: Zero outs points if there is no one in the group
  #
  # Returns a 0 if the value is adjusted
  def zero_out_points
    unless GroupUser.where(group_id: self.group_id).count > 1
      self.point_value = 0
    end
  end
end
