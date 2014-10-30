class V1::InvitesController < V1::ApiController
  before_filter :verify_access_token

  def create
    @group = Group.find(params[:group_id])
    @invites = []

    params[:invites].each do |invite|
      @invite = @group.invites.build
      @invite.to = invite[:to]
      @invite.user = current_user
      @invite.save
      @invites << @invite
    end

    render json: @invites
  end

  protected 

  def invite_params
    params.permit(:user_id, :to, :group_id)
  end
end
