class V1::DevicesController < V1::ApiController
  before_filter :verify_access_token

  def create
    @user = User.find(params[:user_id])
    @device = @user.devices.build(device_params)
    if @device.save
      render json: @device
    else
      unprocessable_entity!
    end
  end

  private

  def device_params
    params.require(:device).permit(:token, :brand, :user_id)
  end
end
