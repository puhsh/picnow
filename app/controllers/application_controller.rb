class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html

  def ios_native_request?
    request.user_agent && request.user_agent.match(/PicNow-iOS/)
  end
  helper_method :ios_native_request?

  def android_native_request?
    request.user_agent && request.user_agent.match(/PicNow-Android/)
  end
  helper_method :android_native_request
end
