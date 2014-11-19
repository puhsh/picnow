class GroupPhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :image_urls, :point_value

  def image_urls
    if object.photo.present?
      object.photo.image_urls
    else
      {}
    end
  end

end
