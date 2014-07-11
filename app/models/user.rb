class User < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :groups, through: :group_users
  
  # Validations
  
  # Scopes

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Methods
end
