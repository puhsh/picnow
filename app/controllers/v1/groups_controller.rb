class V1::GroupsController < V1::ApiController
  before_filter :verify_access_token

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups.order(last_photo_sent_at: :desc)
    render json: @groups, each_serializer: GroupArraySerializer
  end

  def show
    @group = Group.includes(:users).find(params[:id])
    render json: @group
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render json: @group
    else
      unprocessable_entity!
    end
  end

  def activity
    @group = Group.includes({photos: :user}, {comments: :user}).find(params[:id])
    @activity = @group.activity
    render json: @activity
  end

  protected

  def group_params
    params.requre(:group).permit(:name)
  end

end
