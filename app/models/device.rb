class Device < ActiveRecord::Base
  symbolize :brand, in: [:android, :ios], methods: true, scopes: :shallow

  # Relations
  belongs_to :user

  # Callbacks
  before_create :sanitize_token
  
  # Validations
  validates :token, presence: true, uniqueness: { scope: :user_id }, allow_nil: true
  
  # Scopes

  # Methods

  # Public: Fires a notification to a device
  #
  # Returns an Rpush object
  def fire_notification!(message, event)
    return unless message && event

    if self.android?
      self.send_gcm_notification(message)
    elsif self.ios?
      self.send_apn_notification(message, event)
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
  def send_gcm_notification(message)
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("pic_now_#{Rails.env}_android")
    n.registration_ids = [self.token]
    n.data = { message: message }
    n.save!
  end

  # Sends an APN notification
  #
  # Returns an Rpush object
  def send_apn_notification(message, event)
    n = Rpush::Apns::Notification.new
    n.app = Rpush::Apns::App.find_by_name("pic_now_#{Rails.env}")
    n.device_token = self.token
    n.badge = self.user.notifications.where(read: false).count
    n.alert = message
    n.data = { event: event }
    n.save!
  end
end
