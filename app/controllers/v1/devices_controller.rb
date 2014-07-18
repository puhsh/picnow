class V1::DevicesController < V1::ApiController
  def create
    @device = Device.new(params[:device])
    if @device.save
      render json: @device
    else
      unprocessable_entity!
    end
  end
end
