class GroupPhoto < ActiveRecord::Base
  include Eventable

  # Relations
  belongs_to :group
  belongs_to :photo
  belongs_to :user

  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
