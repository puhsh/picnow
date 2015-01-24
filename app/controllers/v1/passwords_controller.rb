class V1::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token, only: [:create], if: :json_request?
end
