class V1::PhotosController < V1::ApiController
  before_filter :verify_access_token

  def index
    @group = Group.includes({photos: :user}).find(params[:group_id])
    @photos = @group.photos
    render json: @photos
  end

  def create
    @user = User.find(params[:user_id])
    @photo = Photo.new(photo_params)
    @photo.user = @user

    if params[:group_ids]
      @groups = Group.where(id: params[:group_ids])
      @groups.each do |group|
        @group_photo = @photo.group_photos.build
        @group_photo.user = @user
        @group_photo.point_value = params[:point_value] || 99
        @group_photo.group = group
      end
    else
      unprocessable_entity!
    end

    if @photo.save
      if params[:point_value].try { |x| x < 99 }
        @user.touch(:forced_pic_last_sent_at)
      end

      render json: @photo
    else
      unprocessable_entity!
    end
  end


  protected

  def photo_params
    params.require(:photo).permit(:image)
  end
end
