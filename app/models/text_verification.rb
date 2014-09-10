class TextVerification < ActiveRecord::Base
  # Relations
  belongs_to :user
  
  # Callbacks
  
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
  def verify!
    self.update_attributes(confirmed_at: DateTime.now)
  end
end
