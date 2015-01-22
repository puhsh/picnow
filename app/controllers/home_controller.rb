class HomeController < ApplicationController
  def index
    if Rails.env.production?
      redirect_to 'www.picnow.rocks'
    end
  end

  def show
  end
end
