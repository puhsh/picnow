class Photo < ActiveRecord::Base
  include Pointable

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
  
  # Validations
   validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/jpg', 'image/png']
  
  # Scopes
  
  # Methods

  # Public: Calculates a hash of image urls per size
  #
  # Returns a hash
  def image_urls
    {
      large: image.url(:large),
      original: image.url,
      medium: image.url(:medium),
      small: image.url(:small)
    }
  end
end
