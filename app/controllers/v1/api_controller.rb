class V1::ApiController < ActionController::Metal
  include ActionController::Rendering
  include ActionController::Renderers::All  
  include ActionController::Redirecting
  include AbstractController::Callbacks
  include AbstractController::Helpers
  include ActionController::Instrumentation
  include ActionController::ParamsWrapper  
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include ActionController::ForceSSL
  include ActionController::Rescue    
  include ActionController::Serialization
  include Rails.application.routes.url_helpers

  respond_to :json
end
