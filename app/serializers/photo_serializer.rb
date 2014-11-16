class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :image_urls, :point_value
end
