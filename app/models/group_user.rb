class GroupUser < ActiveRecord::Base
  include Eventable

  # Relations
  belongs_to :group
  belongs_to :user
  belongs_to :added_by_user, class_name: 'User', foreign_key: 'added_by_user_id'

  # Callbacks
  after_commit :notify_user, on: :create
  # after_commit :notify_members, on: :create
  after_destroy :record_event

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
    if group && admin && self.user_id != self.admin.id
      self.user.devices.each { |x| x.fire_notification!("#{admin.username} added you to the group #{group.name}", :added_to_group, { group_id: group.id, group: group.as_json }) }
    end
  end

  # TODO Enable this once 1.2 goes live
  # Protected: Notifies all the group members that someone joined the group_id
  #
  # Returns nothing
  # def notify_members
  #   group = self.group
  #   user = self.user
  #   group.users.each do |user|
  #     next if user.id == self.user_id
  #     self.user.devices.each { |x| x.fire_notification!("#{user.username} joined the group #{group.name}", :joined_group, { group_id: group.id, group: group.as_json }) }
  #   end
  # end
end
