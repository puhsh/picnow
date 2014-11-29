class NewUserSerializer < UserSerializer
  attributes :text_verification, :access_token

  def text_verification
    object.text_verification_cache
  end

  def access_token
    object.access_token_cache
  end

end
