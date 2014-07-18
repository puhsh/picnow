class V1::AuthController < V1::ApiController
  after_filter :set_csrf_header, only: [:create]

  def create
    resource = User.find_by_email(params[:email]) || User.find_by_username(params[:username])
    if resource && resource.valid_password?(params[:password])
      sign_in 'user', resource
      render json: resource.as_json.merge({access_token: resource.access_token})
    else
      warden.custom_failure!
      unauthorized!
    end
  end
end
