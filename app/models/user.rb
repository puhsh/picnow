class User < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :photos
  
  # Callbacks
  
  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
  validates :date_of_birth, presence: true
  
  # Scopes

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Methods

  # Public: Determines if a user is of valid age, i.e. they are older than 13
  #
  # Returns a boolean
  def valid_age?
    self.date_of_birth < 13.years.ago
  end
end
