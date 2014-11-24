class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :date_of_birth, :phone_number, :pic_now_count, :image_urls, :verified_account, :show_progress_bar

  def verified_account
    object.verified_account?
  end

  def show_progress_bar
    object.show_progress_bar?
  end
end
