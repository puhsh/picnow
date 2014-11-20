class Photo < ActiveRecord::Base
  include Pointable
  include Sizeable

  # Paperclip
  has_attached_file :image,
                    styles: { large: '1280x1280#', medium: '640x640#', small: '320x320#' },
                    s3_permissions: :public_read,
                    s3_headers: { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate },
                    path: 'photos/:id-:style-:fingerprint.:extension',
                    use_timestamp: false

  # Relations
  belongs_to :user
  has_many :group_photos
  has_many :groups, through: :group_photos
  has_many :events, as: :resource
  has_many :notifications, as: :trigger
  
  # Callbacks
  after_commit :touch_group_last_photo_sent_at
  after_commit :notify_group_users, on: :create
  
  # Validations
  validates :user, presence: true
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/jpg', 'image/png']
  
  # Scopes
  default_scope -> { order(created_at: :desc).limit(25) }
  scope :recent, -> { where('photos.created_at >= ?', 1.week.ago) }
  
  # Methods

  protected

  # Protected: Sets the groups 'last_photo_sent_at' column to this photos created_at
  #
  # Returns
  def touch_group_last_photo_sent_at
    self.groups.update_all(last_photo_sent_at: self.created_at)
  end

  def notify_group_users
    group_ids = self.group_photos.select(:group_id)
    group_users = GroupUser.includes(:user).where(group_id: group_ids).where.not(user_id: self.user_id)
    group_users.each do |group_user|
      Notification.create(user_id: group_user.user_id, group_id: group_user.group_id, trigger: self)
      group_user.user.devices.each { |x| x.fire_notification!("PicNow from #{self.user.username}", :picnow) }
    end
  end
end
