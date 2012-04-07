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

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      redirect_to @tournament
    else
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

  def destroy
    Tournament.find(params[:id]).destroy
    redirect_to tournaments_path
  end
end
