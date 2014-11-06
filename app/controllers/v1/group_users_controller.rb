class V1::GroupUsersController < V1::ApiController
  before_filter :verify_access_token

  def create
    @group = Group.find(params[:group_id])
    @group_user = @group.group_users.build(group_user_params)
    if @group_user.save
      render json: @group_user
    else
      unprocessable_entity!
    end
  end

  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.touch(:deleted_at)
    render json: @group_user
  end

  protected

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id)
  end

end
