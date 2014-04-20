class GalleriesController < ApplicationController
	before_action :authenticate_user!

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
    @gallery.gallery_images.build
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      redirect_to root_path, notice: 'Gallery Successfully Created'
    else
      render action: 'new'
    end
  end


  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(gallery_params)
      redirect_to root_path, notice: 'Successfully updated Gallery'
    else
      render action: 'edit'
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to root_path, notice: 'Successfully Destroyed Gallery'
  end

  def show
    @gallery = Gallery.find(params[:id])
  end


  private

  def gallery_params
    params.require(:gallery).permit(:id, :tournament_id, gallery_images_attributes: [:id, :gallery_id, :photo, :_destroy])
  end
end
