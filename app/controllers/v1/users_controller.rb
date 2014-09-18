class V1::UsersController < V1::ApiController
  before_filter :verify_access_token, except: [:create]
  skip_before_filter :verify_authenticity_token, only: [:create], if: :json_request?
  after_filter :set_csrf_header, only: [:create]

  def index
    if params[:group_id]
      @group = Group.includes(:users).find(params[:group_id])
      @users = @group.users
    end
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_access_token!
      sign_in :user, @user
      render json: @user.as_json.merge({access_token: @user.access_token})
    else
      unprocessable_entity!({meta: @user.errors.full_messages.first})
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: @user
    else
      unprocessable_entity!
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :phone_number)
  end
end
