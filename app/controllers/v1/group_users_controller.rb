class V1::GroupUsersController < V1::ApiController
  before_filter :verify_access_token

  def create
    @group_users = []
    @group = Group.find(params[:group_id])
    if params[:user_ids]
      params[:user_ids].each do |user_id|
        @group_user = @group.group_users.build
        @group_user.user_id = user_id
        @group_user.save
        @group_users << @group_user
      end
    else 
      @group_user = @group.group_users.build(group_user_params)
      @group_user.save
      @group_users << @group_user
    end

    render json: @group_users
  end

  def remove
    @group_user = GroupUser.where(user_id: params[:user_id], group_id: params[:group_id]).first
    @group_user.destroy
    render json: @group_user
  end

  protected

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id)
  end

end
