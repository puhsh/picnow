class Photo < ActiveRecord::Base
  include Pointable

  # Relations
  belongs_to :user
  belongs_to :group
  
  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
