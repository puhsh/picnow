class TextVerification < ActiveRecord::Base
  # Relations
  belongs_to :user
  
  # Callbacks
  after_commit :send_verification_code, on: :create
  after_commit :auto_verifiy, on: :create
  
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

  protected

  def twilio_client
    account_sid = Rails.application.secrets[:twilio]['sid']
    auth_token = Rails.application.secrets[:twilio]['auth_token']
    Twilio::REST::Client.new(account_sid, auth_token)
  end

  # Protected: Sends the verification code to the user's phone number using Twilio
  #
  # Returns a Twilio::REST::Message object
  def send_verification_code
    unless self.verified?
      to_phone_number = Rails.env.production? ? self.user.phone_number : Rails.application.secrets[:twilio]['valid_to_phone_number']
      self.twilio_client.account.messages.create(
        from: "+#{Rails.application.secrets[:twilio]['phone_number']}",
        to: to_phone_number,
          body: self.code
      )
    end
  end

  # Protected: Autoverifies the account for not production environments
  #
  # Returns nothing
  def auto_verifiy
    if !Rails.env.production?
      self.update_attributes(confirmed_at: DateTime.now)
    end
  end
end
