class Device < ActiveRecord::Base
  symbolize :brand, in: [:android, :ios], methods: true, scopes: :shallow

  # Relations
  belongs_to :user

  # Callbacks
  before_create :sanitize_token

  # Validations
  validates :token, presence: true, uniqueness: true, allow_nil: true

  # Scopes

  # Methods

  # Public: Fires a notification to a device
  #
  # Returns an Rpush object
  def fire_notification!(message, event, meta = {})
    return unless message && event

    if self.android?
      self.send_gcm_notification(message, meta)
    elsif self.ios?
      self.send_apn_notification(message, event, meta)
    else
      nil
    end
  end

  protected

  # Protected: Cleans up device tokens so they dont have random spaces
  #
  # Returns a sanitized token
  def sanitize_token
    self.token = self.token.delete(" ")
  end

  # Protected: Sends a GCM Notification
  #
  # Returns an Rpush object
  def send_gcm_notification(message, meta)
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("pic_now_#{Rails.env}_android")
    n.registration_ids = [self.token]
    n.data = { message: message, meta: meta}
    n.save!
  end

  # Sends an APN notification
  #
  # Returns an Rpush object
  def send_apn_notification(message, event, meta)
    n = Rpush::Apns::Notification.new
    n.app = Rpush::Apns::App.find_by_name("pic_now_#{Rails.env}")
    n.device_token = self.token
    n.badge = self.user.notifications.where(read: false).count
    n.alert = message
    n.data = { event: event, meta: meta }
    n.save!
  end
end
