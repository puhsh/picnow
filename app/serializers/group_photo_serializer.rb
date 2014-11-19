class GroupPhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :image_urls, :point_value

  def image_urls
    object.photo.image_urls
  end

end
