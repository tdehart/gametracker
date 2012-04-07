class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    @developers = Developer.all
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
    @developers = Developer.all
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to @game
    else
      @developers = Developer.all
      render 'edit'
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    redirect_to games_path
  end
end
