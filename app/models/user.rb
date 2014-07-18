class User < ActiveRecord::Base
  include Sizeable
  
  has_attached_file :avatar,
                    styles: { large: '1280x1280#', medium: '640x640#', small: '320x320#' },
                    s3_permissions: :public_read,
                    s3_headers: { 'Expires' => 10.years.from_now.httpdate },
                    path: 'users/:id-avatar-:style-:fingerprint.:extension',
                    use_timestamp: false

  # Relations
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :photos
  has_many :comments, dependent: :destroy
  has_many :devices, dependent: :destroy
  
  # Callbacks
  
  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :date_of_birth, presence: true
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/jpg', 'image/png']
  
  # Scopes

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Methods

  # Public: Determines if a user is of valid age, i.e. they are older than 13
  #
  # Returns a boolean
  def valid_age?
    self.date_of_birth < 13.years.ago
  end
end
