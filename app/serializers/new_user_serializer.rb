class NewUserSerializer < UserSerializer
  has_one :text_verification
  has_one :access_token
end
