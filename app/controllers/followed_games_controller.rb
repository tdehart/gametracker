class FollowedGamesController < ApplicationController
  before_action :signed_in?

  respond_to :html, :js

  def create
    @game = Game.find(params[:followed_game][:game_id])
    current_user.follow!(@game)
    respond_with @game
  end

  def destroy
    @game = FollowedGame.find(params[:id]).game
    current_user.unfollow!(@game)
    respond_with @game
  end
end