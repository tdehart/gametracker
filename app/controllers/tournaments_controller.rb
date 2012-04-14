class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def new
    @tournament = Tournament.new
    @games = Game.all
  end

  def events
    @tournament = Tournament.find(params[:id])
    @event = @tournament.events.build(:date => @tournament.date)
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      redirect_to :action => :events, :id => @tournament.id
    else
      @games = Game.all
      render 'new'
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
    @games = Game.all
  end


  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      redirect_to @tournament
    else
      @games = Game.all
      render 'edit'
    end
  end

  def update_events

  end

  def destroy
    Tournament.find(params[:id]).destroy
    redirect_to tournaments_path
  end
end
