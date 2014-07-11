class GroupSerializer < ActiveModel::Serializer
  attributes :id, :last_photo_sent_at, :created_at, :updated_at
  has_many :users
end
