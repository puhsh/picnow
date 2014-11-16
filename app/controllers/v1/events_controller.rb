class V1::EventsController < V1::ApiController
  def index
    @group = Group.find(params[:group_id])
    @events = Event.includes(:user).where(group_id: @group.id)
    render_paginated @events
  end
end
