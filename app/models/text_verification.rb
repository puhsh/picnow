class TextVerification < ActiveRecord::Base
  # Attributes
  attr_reader :twilio_client

  # Relations
  belongs_to :user
  
  # Callbacks
  after_commit :send_verification_code, on: :create
  
  # Validations
  
  # Scopes

  # Devise

  # Methods
  
  # Public: Determines if someone has verified their accoutn
  #
  # Returns a boolean
  def verified?
    self.confirmed_at.present?
  end

  # Public: Verifies someone's account
  #
  # Returns a TextVerification record
  def verify!(user, code)
    if self.user_id == user.id && self.code == code
      self.update_attributes(confirmed_at: DateTime.now)
    end
  end

  # Public: Resends the verification code to a user
  #
  # Returns nothing
  def resend_verification_code!
    self.send_verification_code
  end

  def twilio_client
    account_sid = Rails.application.secrets[:twilio]['sid']
    auth_token = Rails.application.secrets[:twilio]['auth_token']
    @twilio_client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  protected

  # Protected: Sends the verification code to the user's phone number using Twilio
  #
  # Returns a TextVerification
  def send_verification_code
  end
end
