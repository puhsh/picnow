class GroupSerializer < ActiveModel::Serializer
  attributes :id, :last_photo_sent_at, :created_at, :updated_at
  has_many :users
  has_many :photos

  def photos
    object.photos.order('created_at desc').limit(20)
  end
end
