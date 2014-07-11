class V1::UsersController < V1::ApiController
  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
