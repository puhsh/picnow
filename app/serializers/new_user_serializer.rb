class NewUserSerializer < UserSerializer
  attributes :text_verification
  has_one :access_token

  def text_verification
    object.text_verification_cache
  end
end
