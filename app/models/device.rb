class Device < ActiveRecord::Base
  symbolize :brand, in: [:android, :ios], methods: true, scopes: :shallow

  # Relations
  belongs_to :user

  # Callbacks
  
  # Validations
  validates :token, presence: true, uniqueness: { scope: :user_id }
  
  # Scopes

  # Methods
end
