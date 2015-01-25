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
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Rails.application.routes.url_helpers
  include ApiResponses

  before_filter :skip_trackable

  # protect_from_forgery with: :null_session, if: :json_request?

  def verify_access_token
    if bypass_auth?
      true
    else
      authenticate_or_request_with_http_token do |token, opts|
        current_user && token && current_user.access_token.token == token
      end
    end
  end

  # TODO Fully build this out when we start paginating stuff...
  def render_paginated(resource, opts = {})
    render json: resource, root: 'items', meta: {}
  end

  protected

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
