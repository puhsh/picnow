class GroupUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :group_id
  has_one :user, serializer: UserSerializer
end
