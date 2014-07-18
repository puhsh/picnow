class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :created_at, :updated_at, :image_urls, :resource_name
  has_one :user

  def resource_name
    object.class.to_s.downcase
  end
end
