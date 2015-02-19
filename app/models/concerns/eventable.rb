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
      @event.user_id = self.user_id
      @event.payload = GroupPhotoSerializer.new(self).to_json
      @event.resource = self.photo
    when Comment
      @event.group_id = self.group_id
      @event.user_id = self.user_id
      @event.payload = CommentSerializer.new(self).to_json
      @event.resource = self
    when GroupUser
      @event.group_id = self.group_id
      @event.payload = GroupUserSerializer.new(self).to_json
      if GroupUser.where(id: self.id).exists?
        @event.user_id = self.added_by_user_id
        @event.resource = self
      else
        @event.user_id = self.user_id
        @event.resource_type = "GroupUser"
        @event.resource_id = nil
      end
    else
    end

    @event.save
  end

end
