# LOL what a terrible name....I blame DHH
module ActivityIndicatable
  extend ActiveSupport::Concern

  included do
    after_commit :touch_last_activity_at, on: :create
  end

  protected

  def touch_last_activity_at
    self.group.touch(:last_activity_at)
  end
end
