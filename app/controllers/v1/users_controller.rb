class V1::UsersController < V1::ApiController
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      render json: @user
    else
      unprocessable_entity!({from_warden: true})
    end
  end
end