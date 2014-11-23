class V1::NotificationsController < V1::ApiController
  before_filter :verify_access_token

  def index
    @filter = params[:read] || false
    @notifications = Notification.where(user_id: params[:user_id], group_id: params[:group_id], read: @filter)
    render json: @notifications
  end

  def mark_as_read
    @group = Group.find(params[:group_id])
    @user = User.find(params[:user_id])
    if @group && @user
      @group.mark_notifications_as_read!(@user)
    end

    render json: @group
  end
end
