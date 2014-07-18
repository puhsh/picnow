class V1::CommentsController < V1::ApiController
  before_filter :verify_access_token

  def create
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @comment = Comment.new(params[:comment])
    @comment.user = @user
    @comment.group = @group
    if @comment.save
      render json: @comment
    else
      unprocessable_entity!
    end
  end
end
