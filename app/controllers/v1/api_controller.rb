class V1::ApiController < ActionController::Metal
  include AbstractController::Rendering
  include ActionView::Layouts
  include ActionController::Serialization
  include ActionController::Rendering
  include ActionController::Renderers::All  
  include ActionController::Redirecting
  include AbstractController::Callbacks
  include AbstractController::Helpers
  include ActionController::ParamsWrapper  
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::ForceSSL
  include ActionController::Instrumentation
  include Devise::Controllers::Helpers
  include ActionController::RequestForgeryProtection
  include ActionController::StrongParameters
  include ActionController::Rescue 
  include Rails.application.routes.url_helpers

  before_filter :skip_trackable

  protect_from_forgery with: :null_session, if: :json_request?

  def verify_access_token
    forbidden! unless (current_user && params[:token] && current_user.access_token.token == params[:token]) || bypass_auth?
  end
  
  # TODO Fully build this out when we start paginating stuff...
  def render_paginated(resource, opts = {})
    render json: resource, root: 'items', meta: {}
  end

  protected

  def unprocessable_entity!(opts={})
    render json: { error: 'Unprocessable entity', meta: opts[:meta] }, status: :unprocessable_entity
  end

  def forbidden!
    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def unauthorized!(resource = nil)
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def json_request?
    request.format.json?
  end

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def bypass_auth?
    Rails.env.development? && params[:debug]
  end

  def skip_trackable
    request.env["devise.skip_trackable"] = true
  end
end
