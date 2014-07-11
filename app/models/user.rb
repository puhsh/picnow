class User < ActiveRecord::Base
  # Relations
  
  # Validations
  
  # Scopes

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Methods
end
