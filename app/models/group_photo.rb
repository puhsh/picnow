class GroupPhoto < ActiveRecord::Base
  include Pointable
  include Eventable
  include ActivityIndicatable

  # Relations
  belongs_to :group
  belongs_to :photo
  belongs_to :user
  has_one :notification, as: :trigger

  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
