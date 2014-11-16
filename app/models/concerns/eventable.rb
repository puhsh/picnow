module Eventable 
  extend ActiveSupport::Concern

  included do
    after_create :record_event
  end

  def record_event
    @event = Event.new
    @event.user_id = self.user_id

    case self
    when GroupPhoto
      @event.group_id = self.group_id
      @event.payload = self.photo.to_json
      @event.resource = self.photo
    when Comment
      @event.group_id = self.group_id
      @event.payload = self.to_json
      @event.resource = self
    else
    end

    @event.save
  end

end
