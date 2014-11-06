class GroupUser < ActiveRecord::Base
  # Relations
  belongs_to :group
  belongs_to :user

  # Callbacks
  
  # Validations
  validates :user, presence: true
  validates :group, presence: true
  
  # Scopes
  scope :not_deleted, -> { where(deleted_at: nil) }

  # Methods
end
