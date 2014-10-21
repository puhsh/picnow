class V1::InvitesController < V1::ApiController
  before_filter :verify_access_token

  def create
    @invite = Invite.new(invite_params)
    if @invite.save
      render json: @invite
    else
      unprocessable_entity!
    end
  end

  protected 

  def invite_params
    params.require(:invite).permit(:user_id, :to, :group_id)
  end
end
