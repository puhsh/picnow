class Comment < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :group

  # Callbacks
  
  # Validations
  validates :content, presence: true, length: { maximum: 40 }
  
  # Scopes

  # Methods
end
