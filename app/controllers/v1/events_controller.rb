class V1::EventsController < V1::ApiController
  def index
    @group = Group.find(params[:group_id])
    @events = @group.recent_events
    render_paginated @events
  end
end
