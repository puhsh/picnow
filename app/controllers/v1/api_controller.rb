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
  include ActionController::RequestForgeryProtection
  include ActionController::ForceSSL
  include ActionController::Instrumentation
end
