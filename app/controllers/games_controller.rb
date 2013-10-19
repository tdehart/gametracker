class GamesController < ApplicationController
  before_action :admin_user?, except: [:index, :show]
  
  def index
    @games = Game.all
  end

  def show
    @game = Game.friendly.find(params[:id])
    @tournaments = @game.tournaments.where { start_date >= Date.today }.order { start_date.asc }.take(10)
  end

  def new
    @game = Game.new
    @developers = Developer.all
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game
    else
      @developers = Developer.all
      render 'new'
    end
  end

  def edit
    @game = Game.friendly.find(params[:id])
    @developers = Developer.all
  end

  def update
    @game = Game.friendly.find(params[:id])
    if @game.update_attributes(game_params)
      redirect_to @game
    else
      @developers = Developer.all
      render 'edit'
    end
  end

  def destroy
    Game.friendly.find(params[:id]).destroy
    redirect_to games_path
  end

  private
  def game_params
    params.require(:game).permit(:name, :website, :genre, :abbreviation, :developer_id, :image)
  end
end
