class V1::CommentsController < V1::ApiController
  before_filter :verify_access_token

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      render json: @comment
    else
      unprocessable_entity!
    end
  end
end
