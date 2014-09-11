class TextVerification < ActiveRecord::Base
  # Relations
  belongs_to :user
  
  # Callbacks
  after_save :resend_verification_token
  
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

  protected
  
  # Protected: Resends the verification code to the user's phone number
  #
  # TODO Implement Twilio
  #
  # Returns a TextVerification
  def resend_verification_token

  end
end
