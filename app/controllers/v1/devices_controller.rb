class V1::DevicesController < V1::ApiController
  before_filter :verify_access_token

  def create
    @device = Device.new(params[:device])
    if @device.save
      render json: @device
    else
      unprocessable_entity!
    end
  end
end
