class Device < ActiveRecord::Base
  symbolize :brand, in: [:android, :ios], methods: true, scopes: :shallow

  # Relations
  belongs_to :user

  # Callbacks
  before_create :sanitize_token
  
  # Validations
  validates :token, presence: true, uniqueness: { scope: :user_id }
  
  # Scopes

  # Methods

  protected

  # Protected: Cleans up device tokens so they dont have random spaces
  #
  # Returns a sanitized token
  def sanitize_token
    self.token = self.token.delete(" ")
  end
end
