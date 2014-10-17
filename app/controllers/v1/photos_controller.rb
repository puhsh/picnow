class V1::PhotosController < ApplicationController
  before_filter :verify_access_token

  def index
    @group = Group.includes({photos: :user}).find(params[:group_id])
    @photos = @group.photos
    render json: @photos
  end

  def create
    @user = User.find(params[:user_id])
    @group = Group.find(params[:group_id])
    @photo = Photo.new(params[:photo])
    @photo.user = @user
    @photo.group = @group
    if @photo.save
      render json: @photo
    else
      unprocessable_entity!
    end
  end
end
