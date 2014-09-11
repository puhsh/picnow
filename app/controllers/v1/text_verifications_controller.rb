class V1::TextVerificationsController < V1::ApiController
  before_filter :verify_access_token

  def create
    @user = User.find(params[:user_id])
    if @user
      @user.generate_text_verification!
      respond_with @user
    else
      unprocessable_entity!
    end
  end

  def update
    @user = User.find(params[:user_id])
    if @user && @user.text_verification
      @user.text_verification.save
      respond_with @user
    else
      unprocessable_entity!
    end
  end
end
