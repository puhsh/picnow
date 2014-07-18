class AccessToken < ActiveRecord::Base
  # Relations
  belongs_to :user

  # Callbacks
  
  # Validations
  validates :token, presence: true
  
  # Scopes

  # Methods
end
