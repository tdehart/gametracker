class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      FeedItem.create!(feedable: @event, owner: current_user, key: "Event.create")
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      FeedItem.create!(feedable: @event, owner: current_user, key: "Event.update")
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    FeedItem.create!(feedable: @event, owner: current_user, key: "Event.delete")
    @event.destroy
    redirect_to events_path
  end
end
