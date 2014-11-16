module Eventable 
  extend ActiveSupport::Concern

  included do
    after_create :record_event
  end

  def record_event
    @event = Event.new
    case self
    when GroupPhoto
      @event.group_id = self.group_id
      @event.payload = PhotoSerializer.new(self.photo).to_json
    when Comment
      @event.group_id = self.group_id
      @event.payload = CommentSerializer.new(self).to_json
    else
    end

    @event.save
  end

end
