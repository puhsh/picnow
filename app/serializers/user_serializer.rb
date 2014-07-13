class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :date_of_birth, :phone_number, :pic_now_count, :image_urls
end
