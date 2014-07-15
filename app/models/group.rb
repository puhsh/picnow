class Group < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :users, through: :group_users
  has_many :photos

  # Callbacks
  
  # Validations
  validates :name, presence: true, length: { maximum: 20 }
  
  # Scopes

  # Methods
end
