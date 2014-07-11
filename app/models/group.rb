class Group < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :users, through: :group_users
  
  # Validations
  
  # Scopes

  # Methods
end
