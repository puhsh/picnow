class CommentSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :content, :created_at, :updated_at, :resource_name
  has_one :user

  def resource_name
    object.class.to_s.downcase
  end
end
