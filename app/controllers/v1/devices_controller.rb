class V1::DevicesController < V1::ApiController
  before_filter :verify_access_token

  def create
    @device = Device.new(device_params)
    if @device.save
      render json: @device
    else
      unprocessable_entity!
    end
  end

  private

  def device_params
    params.require(:device).permit(:token, :brand)
  end
end
