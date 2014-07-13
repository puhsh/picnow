class Photo < ActiveRecord::Base
  include Pointable
  include Sizeable

  # Paperclip
  has_attached_file :image,
                    styles: { large: '1280x1280#', medium: '640x640#', small: '320x320#' },
                    s3_permissions: :public_read,
                    s3_headers: { 'Expires' => 10.years.from_now.httpdate },
                    path: 'photos/:id-:style-:fingerprint.:extension',
                    use_timestamp: false

  # Relations
  belongs_to :user
  belongs_to :group
  
  # Callbacks
  after_commit :touch_group_last_photo_sent_at
  
  # Validations
  validates :user, presence: true
  validates :group, presence: true
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/jpg', 'image/png']
  
  # Scopes
  default_scope -> { order(created_at: :desc).limit(25) }
  
  # Methods

  protected

  # Protected: Sets the groups 'last_photo_sent_at' column to this photos created_at
  #
  # Returns
  def touch_group_last_photo_sent_at
    self.group.update_column(:last_photo_sent_at, self.created_at)
  end
end
