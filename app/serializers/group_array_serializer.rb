class GroupArraySerializer < ActiveModel::Serializer
  attributes :id, :name, :last_photo_sent_at, :created_at, :updated_at
end
