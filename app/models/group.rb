class Group < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :users, through: :group_users
  has_many :photos

  # Callbacks
  
  # Validations
  
  # Scopes

  # Methods
end
