class Invite < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :joined_user
  belongs_to :group

  # Callbacks
  
  # Validations
  
  # Scopes

  # Third Party
  phony_normalize :to, default_country_code: 'US'

  # Methods
end
