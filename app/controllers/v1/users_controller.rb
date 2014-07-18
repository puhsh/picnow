class V1::UsersController < V1::ApiController
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
    @user = User.new(params[:user])
    if @user.save
      @user.generate_access_token!
      render json: @user.as_json.merge({access_token: @user.access_token})
    else
      unprocessable_entity!({from_warden: true})
    end
  end
end
