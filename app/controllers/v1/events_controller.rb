class V1::EventsController < V1::ApiController
  def index
    @group = Group.find(params[:group_id])
    @events = @group.events_cached
    render_paginated @events
  end
end
