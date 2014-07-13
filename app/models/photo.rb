class Photo < ActiveRecord::Base
  include Pointable

  # Paperclip
  has_attached_file :image,
                    styles: { original: '1280x1280#', medium: '640x640#', small: '320x320#' },
                    s3_permissions: :public_read,
                    path: 'photos/:id.:extension'

  # Relations
  belongs_to :user
  belongs_to :group
  
  # Callbacks
  
  # Validations
   validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/jpg', 'image/png']
  
  # Scopes
  
  # Methods
end
