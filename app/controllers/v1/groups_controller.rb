class V1::GroupsController < V1::ApiController
  before_filter :verify_access_token

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups.not_deleted.includes(:notifications).order('last_photo_sent_at desc nulls last')
    render json: @groups, each_serializer: GroupArraySerializer
  end

  def show
    @group = Group.includes(:users).find(params[:id])
    render json: @group
  end

  def create
    @group = Group.new(group_params)
    @user = params[:user_id] ? User.find_by_id(params[:user_id]) : current_user
    @group.admin = @user
    @group.group_users.build(user: @user)
    if @group.save
      render json: @group
    else
      unprocessable_entity!
    end
  end

  def activity
    @group = Group.includes({photos: {user: :text_verification}}, {comments: {user: :text_verification}}).find(params[:id])
    @activity = @group.activity
    expires_in 24.hours
    render_paginated @activity
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.touch(:deleted_at)
    @group.group_users.update_all(deleted_at: DateTime.now)
    render json: @group
  end

  protected

  def group_params
    params.require(:group).permit(:name)
  end

end
