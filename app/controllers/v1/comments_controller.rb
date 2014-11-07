class V1::CommentsController < V1::ApiController
  before_filter :verify_access_token

  def create
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @comment = Comment.new(comment_attributes)
    @comment.user = @user
    @comment.group = @group
    if @comment.save
      render json: @comment
    else
      unprocessable_entity!
    end
  end


  protected

  def comment_attributes
    params.require(:comment).permit(:content)
  end
end
