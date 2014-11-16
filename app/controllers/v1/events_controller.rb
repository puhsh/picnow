class V1::EventsController < V1::ApiController
  def index
    @group = Group.find(params[:group_id])
    @events = Event.includes(:user).where(group_id: @group.id).limit(30).order(created_at: :desc).reverse
    render_paginated @events
  end
end
