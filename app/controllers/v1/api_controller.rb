class V1::ApiController < ActionController::Metal
  include AbstractController::Rendering
  include ActionView::Layouts
  include ActionController::Serialization
  include ActionController::Rendering
  include ActionController::Renderers::All  
  include AbstractController::Callbacks
  include AbstractController::Helpers
  include ActionController::ParamsWrapper  
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::ForceSSL
  include ActionController::Instrumentation
  include Devise::Controllers::Helpers
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session, if: :json_request?

  def verify_access_token
    forbidden! unless current_user && params[:token] && current_user.access_token.token == params[:token]
  end

  protected

  def unprocessable_entity!(opts={})
    warden.custom_failure! if opts[:from_warden]
    render json: { error: 'Unprocessable entity', meta: opts[:meta] }, status: :unprocessable_entity
  end

  def forbidden!
    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def json_request?
    request.format.json?
  end

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end
end
