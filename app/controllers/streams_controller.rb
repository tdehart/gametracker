class StreamsController < ApplicationController
  before_action :admin_user?, except: [:index, :show]
  
  def index
    # @streams = Stream.live
    @streams = Stream.includes(:current_game).all
  end

  def show
    @stream = Stream.find(params[:id])
  end

  def new
    @stream = Stream.new
    @streamers = Streamer.all
    @games = Game.all
  end

  def create
    @stream = Stream.new(stream_params)
    if @stream.save
      redirect_to @stream
    else
      render 'new'
    end
  end

  def edit
    @stream = Stream.find(params[:id])
    @streamers = Streamer.all
    @games = Game.all
  end

  def update
    @stream = Stream.find(params[:id])
    if @stream.update_attributes(stream_params)
      redirect_to @stream
    else
      @streamers = Streamer.all
      @games = Game.all
      render 'edit'
    end
  end

  def destroy
    Stream.find(params[:id]).destroy
    redirect_to streams_path
  end

  private
  def stream_params
    params.require(:stream).permit(:link, :description, :channel_id, :name, :current_game_name, :image, :remote_image_url)
  end  
end
