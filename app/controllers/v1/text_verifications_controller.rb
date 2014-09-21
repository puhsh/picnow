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
    @user = User.find(params[:user_id])
    @text_verification = TextVerification.find(params[:id])
    if !@user.present? || !@text_verification.present?
      unprocessable_entity!
    elsif params[:code] && @text_verification.verify!(@user, params[:code])
      render json: @user
    elsif @user.resend_verification_code!
      render json: @user
    else
      unprocessable_entity!
    end
  end
end
