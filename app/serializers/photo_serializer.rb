class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :image_urls, :resource_name, :point_value
  has_one :user, serializer: UserSerializer

  def resource_name
    object.class.to_s.downcase
  end
end
