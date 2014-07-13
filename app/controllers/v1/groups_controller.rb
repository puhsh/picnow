class V1::GroupsController < V1::ApiController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups.includes(:users, {photos: :user}).order('groups.last_photo_sent_at desc')
    render json: @groups
  end

  def show
    @group = Group.includes(:users).find(params[:id])
    render json: @group
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      render json: @group
    else
      unprocessable_entity!
    end
  end
end
