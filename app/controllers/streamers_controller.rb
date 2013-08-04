class StreamersController < ApplicationController
  before_action :admin_user?, except: [:index, :show]
  
  def index
    @streamers = Streamer.all
  end

  def show
    @streamer = Streamer.find(params[:id])
  end

  def new
    @streamer = Streamer.new
    @developers = Developer.all
  end

  def create
    @streamer = Streamer.new(streamer_params)
    if @streamer.save
      redirect_to @streamer
    else
      render 'new'
    end
  end

  def edit
    @streamer = Streamer.find(params[:id])
  end

  def update
    @streamer = Streamer.find(params[:id])
    if @streamer.update_attributes(streamer_params)
      redirect_to @streamer
    else
      render 'edit'
    end
  end

  def destroy
    Streamer.find(params[:id]).destroy
    redirect_to streamers_path
  end

  private
  def streamer_params
    params.require(:streamer).permit(:online_name, :real_name, :nationality, :website, :birthday, :biography, :image, :remote_image_url)
  end

end
