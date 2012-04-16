class StreamersController < ApplicationController
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
    @streamer = Streamer.new(params[:streamer])
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
    if @streamer.update_attributes(params[:streamer])
      redirect_to @streamer
    else
      render 'edit'
    end
  end

  def destroy
    Streamer.find(params[:id]).destroy
    redirect_to streamers_path
  end
end
