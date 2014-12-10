class GroupUser < ActiveRecord::Base
  # Relations
  belongs_to :group
  belongs_to :user

  # Callbacks
  after_commit :notify_user, on: :create
  
  # Validations
  validates :user, presence: true
  validates :group, presence: true
  
  # Scopes

  # Methods

  protected

  # Protected: Notifies the user that they were added to a group
  #
  # Returns nothing
  def notify_user
    group = self.group
    admin = self.group.admin
    if group && admin
      self.user.devices.each { |x| x.fire_notification!("#{admin.username} added you to the group #{group.name}", :added_to_group, { group_id: group.id }) }
    end
  end
end
