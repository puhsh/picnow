class GroupArraySerializer < ActiveModel::Serializer
  attributes :id, :last_photo_sent_at, :created_at, :updated_at
end
