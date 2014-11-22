class V1::UsersController < V1::ApiController
  before_filter :verify_access_token, except: [:create]
  skip_before_filter :verify_authenticity_token, only: [:create], if: :json_request?
  skip_before_filter :skip_trackable, only: [:create]
  after_filter :set_csrf_header, only: [:create]

  def index
    if params[:group_id]
      @group = Group.includes(:users).find(params[:group_id])
      @users = @group.users.where('group_users.deleted_at is null').order(pic_now_count: :desc)
    end
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: NewUserSerializer
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_access_token!
      reset_session
      sign_in :user, @user, event: :token_authentication
      render json: @user, serializer: NewUserSerializer
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

  def avatar
    @user = User.find(params[:id])
    if params[:user][:avatar] && @user.update_attributes(user_params)
      render json: @user
    else
      unprocessable_entity!
    end
  end

  def friends
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id]
    @friends = @user.friends(@group).order(username: :asc)
    render json: @friends
  end

  def friends_from_contacts
    @normalized_numbers = []
    params[:phone_numbers].each do |number|
      @normalized_numbers << PhonyRails.normalize_number(number, county_number: 1)
    end

    # TODO LOL THIS WONT SCALE LOL
    @users = User.where(phone_number: @normalize_numbers).order(username: :asc)

    render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :phone_number, :avatar)
  end
end
