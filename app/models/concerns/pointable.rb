module Pointable
  extend ActiveSupport::Concern

  included do
    after_commit :add_point, on: :create
  end

  def reset_points!
    self.user.update_column(:pic_now_count, 0)
  end

  protected

  def add_point
    self.user.increment(:pic_now_count, 1).save
  end
end
