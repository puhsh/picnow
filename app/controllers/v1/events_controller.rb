class V1::EventsController < V1::ApiController
  def index
    @group = Group.find(params[:group_id])
    if params[:include_group_user_events]
      @events = Event.includes(:user).where(group_id: @group.id)
                                     .limit(50)
                                     .order(created_at: :desc)
                                     .reverse
    else
      @events = Event.includes(:user).exclude_group_users
                                     .where(group_id: @group.id)
                                     .limit(50)
                                     .order(created_at: :desc)
                                     .reverse
    end
    render_paginated @events
  end
end
