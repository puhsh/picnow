class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :created_at, :updated_at
  has_one :user
end
