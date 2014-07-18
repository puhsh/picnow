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

  protect_from_forgery

  protected

  def unprocessable_entity!(opts={})
    warden.custom_failure! if opts[:from_warden]
    render json: { error: 'Unprocessable entity', meta: opts[:meta] }, status: :unprocessable_entity
  end
end
