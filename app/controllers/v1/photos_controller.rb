class V1::PhotosController < ApplicationController
  def index
    @group = Group.includes({photos: :user}).find(params[:group_id])
    @photos = @group.photos
    render json: @photos
  end

  def create
    @user = User.find(params[:user_id])
    @photo = Photo.new(params[:photo])
    @photo.user = @user
    if @photo.save
      render json: @photo
    else
      unprocessable_entity!
    end
  end
end
