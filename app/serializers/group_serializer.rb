class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_photo_sent_at, :created_at, :updated_at, :admin_id, :points_enabled, :group_type, :last_activity_at
end
