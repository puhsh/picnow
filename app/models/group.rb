class Group < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_photos
  has_many :photos, through: :group_photos
  has_many :comments
  has_many :invites
  has_many :notifications
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  # Callbacks
  
  # Validations
  validates :name, presence: true, length: { maximum: 20 }
  
  # Scopes
  default_scope -> { where(deleted_at: nil) }

  # Methods
  
  # Public: Gets the activity for a given group
  #
  # Returns an array of Comment and Photo objects
  def activity
    (self.photos.recent + self.comments).sort_by(&:created_at)
  end

  # Public: Marks all notifications as read for the given group
  #
  # Returns an array of notifications
  def mark_notifications_as_read!(user)
    self.notifications.where(read: false, user_id: user.id).update_all(read: true)
  end
end
