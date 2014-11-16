class Event < ActiveRecord::Base
  # Relations
  belongs_to :group
  belongs_to :resource, polymorphic: true
  belongs_to :user

  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
