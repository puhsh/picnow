class Group < ActiveRecord::Base
  # Relations
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :group_photos
  has_many :photos, through: :group_photos
  has_many :comments, dependent: :destroy
  has_many :invites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  has_many :events, dependent: :destroy

  # Callbacks
  
  # Validations
  validates :name, presence: true, length: { maximum: 20 }
  
  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Methods
  
  # Public: Gets the activity for a given group from SQL
  #
  # Returns an array of Comment and Photo objects
  def activity
    (self.photos.recent + self.comments.recent).sort_by(&:created_at)
  end

  # Public: Marks all notifications as read for the given group
  #
  # Returns an array of notifications
  def mark_notifications_as_read!(user)
    self.notifications.where(read: false, user_id: user.id).update_all(read: true)
  end


  # Public: Gets the events for a group cached in Memcache
  #
  # Returns an array of Events
  def events_cached
    Rails.cache.fetch "groups:#{self.id}:events:#{self.updated_at}" do
      Event.includes(:user).where(group_id: self.id).limit(50).order(created_at: :desc).reverse
    end
  end
end
