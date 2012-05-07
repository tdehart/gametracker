class StreamsController < ApplicationController
  def index
    @streams = Stream.live
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
    @stream = Stream.new(params[:stream])
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
    if @stream.update_attributes(params[:stream])
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
end
