class Invite < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :joined_user
  belongs_to :group

  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
