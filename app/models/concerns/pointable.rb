module Pointable
  extend ActiveSupport::Concern

  included do
    after_commit :add_points, on: :create
  end

  def reset_points!
    self.user.update_column(:pic_now_count, 0)
  end

  protected

  def add_point
    case self
    when GroupPhoto
      self.user.increment(:pic_now_count, self.point_value).save
    when Comment
      self.user.increment(:pic_now_count, 1).save
    end
  end
end
