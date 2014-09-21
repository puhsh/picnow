class V1::TextVerificationsController < V1::ApiController
  before_filter :verify_access_token

  def create
    @user = User.find(params[:user_id])
    if @user
      @user.generate_text_verification!
      render json: @user
    else
      unprocessable_entity!
    end
  end

  def update
    @text_verification = TextVerification.where(id: params[:id], user_id: params[:user_id]).first
    @user = User.find(params[:user_id])
    if @user && @text_verification && ( did_verify_user? || resent_code_to_user? )
      render json: @user
    else
      unprocessable_entity!
    end
  end


  private 

  def did_verify_user?
    params[:code] && @text_verification.verify!(@user, params[:code])
  end

  def resent_code_to_user?
    !params[:code] && @text_verification.resend_verification_code!
  end
end
