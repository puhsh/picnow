class Group < ActiveRecord::Base
  # Relations
  has_many :group_users
  has_many :users, through: :group_users
  has_many :photos
  has_many :comments
  has_many :invites
  has_many :notifications

  # Callbacks
  
  # Validations
  validates :name, presence: true, length: { maximum: 20 }
  
  # Scopes

  # Methods
  
  # Public: Gets the activity for a given group
  #
  # Returns an array of Comment and Photo objects
  def activity
    (self.photos + self.comments).sort_by(&:created_at)
  end
end
