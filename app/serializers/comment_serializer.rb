class CommentSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :content, :created_at, :updated_at
end
