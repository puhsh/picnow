class V1::GroupsController < V1::ApiController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups if @user

    render json: @groups
  end

  def show
    @group = Group.includes(:users).find(params[:id])
    render json: @group
  end
end
