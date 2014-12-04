class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html

  before_filter :ignore_api_browser_request


  protected

  def ignore_api_browser_request
    if request.subdomain == 'api' 
      redirect_to root_url, subdomain: 'www'
    end
  end
end
