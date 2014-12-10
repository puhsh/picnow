class Comment < ActiveRecord::Base
  include Pointable
  include Eventable
  include ActivityIndicatable

  # Relations
  belongs_to :user
  belongs_to :group
  has_many :events, as: :resource
  has_one :notification, as: :trigger

  # Callbacks
  after_commit :notify_group_users, on: :create
  
  # Validations
  validates :content, presence: true, length: { maximum: 500 }
  
  # Scopes
  scope :recent, -> { where('comments.created_at >= ?', 1.week.ago) }

  # Methods

  protected

  def notify_group_users
    group_users = GroupUser.includes(:user).where(group_id: self.group_id).where.not(user_id: self.user_id)
    group_users.each do |group_user|
      Notification.create(user_id: group_user.user_id, group_id: group_user.group_id, trigger: self)
      group_user.user.devices.each { |x| x.fire_notification!("#{self.user.username}: #{self.content}", :picnow_comment, { group_id: group_user.group_id} ) }
    end
  end
end
