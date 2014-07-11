class GroupUser < ActiveRecord::Base
  # Relations
  belongs_to :group
  belongs_to :user
  
  # Validations
  
  # Scopes

  # Methods
end
