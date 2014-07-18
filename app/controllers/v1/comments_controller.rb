class V1::CommentsController < V1::ApiController
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      render json: @comment
    else
      unprocessable_entity!
    end
  end
end
