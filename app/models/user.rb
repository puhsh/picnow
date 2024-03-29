class User < ActiveRecord::Base
  include Sizeable

  has_attached_file :avatar,
                    styles: { large: '1280x1280#', medium: '640x640#', small: '320x320#', thumbnail: '50x50#' },
                    s3_permissions: :public_read,
                    s3_headers: { 'Cache-Control' => 'max-age=315576000', 'Expires' => 10.years.from_now.httpdate },
                    path: 'users/:id-avatar-:style-:fingerprint.:extension',
                    use_timestamp: false

  # Relations
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :photos, dependent: :destroy
  has_many :group_photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :invites, dependent: :nullify
  has_one :accepted_invite, class_name: 'Invite', foreign_key: 'joined_user_id', dependent: :destroy
  has_one :access_token, dependent: :destroy
  has_one :text_verification, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :owned_groups, class_name: 'Group', foreign_key: 'admin_id', dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :added_group_users, class_name: 'GroupUser', foreign_key: 'added_by_user_id', dependent: :nullify

  # Callbacks
  after_commit :generate_text_verification!, :process_pending_group_invites!, on: :create
  before_save :give_first_point

  # Validations
  validates :username, presence: { message: 'must be legit' }, uniqueness: { message: 'already taken.' }, length: { minimum: 3, message: 'must be at least 3 characters!' }
  validates :email, presence: { message: 'must be legit.' }, uniqueness: { message: 'already taken.' }, format: { with: /@/, message: 'not legit.' }
  validates :phone_number, presence: { message: 'must be legit.' }, uniqueness: { message: 'is already taken.' }
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/jpg', 'image/png']


  # Scopes

  # Devise
  devise :database_authenticatable, :trackable, :recoverable

  # Third Party
  phony_normalize :phone_number, default_country_code: 'US'

  # Methods

  # Public: Determines if a user is of valid age, i.e. they are older than 13
  #
  # Returns a boolean
  def valid_age?
    self.date_of_birth < 13.years.ago
  end

  # Public: Generates an access token for a user
  #
  # Returns an AccessToken
  def generate_access_token!
    AccessToken.create(user: self, token: SecureRandom.hex)
  end

  # Public: Generates a text verification for a user
  #
  # Returns a TextVerification
  def generate_text_verification!
    TextVerification.create(user: self, code: rand(1000...9999))
  end

  # Public: Determines if the user is a verified account
  #
  # Returns a boolean
  def verified_account?
    self.phone_number.present? && self.verified?
  end

  # Public: Gets a text verification record from Memcache
  #
  # Returns a TextVerification
  def text_verification_cache
    Rails.cache.fetch "user:#{self.id}.text_verification" do
      self.text_verification
    end
  end

  # Public Gets an access token record from Memcache
  #
  # Returns an AccessToken
  def access_token_cache
    Rails.cache.fetch "user:#{self.id}:access_token" do
      self.access_token
    end
  end


  # Public: Finds your "friends" on PicNow aka users that are in the same groups you are in
  #
  # Returns a collection of users
  def friends(group = nil)
    current_group_ids = GroupUser.select(:group_id).where(user_id: self.id)
    if group
      user_ids_in_group = GroupUser.select(:user_id).where(group_id: group.id)
      user_ids_in_groups = GroupUser.select(:user_id).where(group_id: current_group_ids).where.not(user_id: user_ids_in_group).where.not(group_id: group.id)
    else
      user_ids_in_groups = GroupUser.select(:user_id).where(group_id: current_group_ids).where.not(user_id: self.id)
    end

    User.where(id: user_ids_in_groups)
  end

  # Protected: Determines if there is an invite that exists for a given user to a given group and adds them to the group
  #
  # Returns group users
  def process_pending_group_invites!
    invites = Invite.where(to: self.phone_number)
    if invites.any?
      invites.each do |x|
        GroupUser.create(user_id: self.id, group_id: x.group_id) unless GroupUser.where(user_id: self.id, group_id: x.group_id).exists?
      end
    end
  end

  # Deprecated: Always returns true as this is now determined at the group level
  #
  # Public: Determines if the user should see the progress bar when viewing a group
  #
  # Returns a boolean
  def show_progress_bar?
    true
  end

  protected

  # Protected: Gives a user their first PicNow point for taking their first selfie
  #
  # Returns true
  def give_first_point
    if self.avatar_file_name_changed? && self.avatar_file_name_was.nil?
      self.increment(:pic_now_count, 99)
    end
  end
end
