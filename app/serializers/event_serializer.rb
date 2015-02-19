class EventSerializer < ActiveModel::Serializer
  attributes :id, :resource_name, :resource, :resource_id, :created_at, :updated_at
  has_one :user, serializer: UserSerializer

  def resource
    object.payload
  end

  def resource_name
    object.resource_type.downcase
  end
end
