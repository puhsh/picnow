class V1::AuthController < V1::ApiController
  skip_before_filter :verify_authenticity_token, only: [:create], if: :json_request?
  skip_before_filter :skip_trackable, only: [:create]
  after_filter :set_csrf_header, only: [:create]

  def create
    unprocessable_entity! unless params[:user]

    resource = User.find_by_username(params[:user][:username])

    if resource && resource.valid_password?(params[:user][:password])
      reset_session
      sign_in 'user', resource
      user = NewUserSerializer.new(resource)
      render json: user.as_json.merge({access_token: resource.access_token})
    else
      warden.custom_failure!
      unauthorized!
    end
  end
end
