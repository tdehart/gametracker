class FollowedTournamentsController < ApplicationController
  before_action :signed_in?

  respond_to :html, :js

  def create
    @tournament = Tournament.find(params[:followed_tournament][:tournament_id])
    current_user.follow!(@tournament)
    respond_with @tournament
  end

  def destroy
      @tournament = FollowedTournament.find(params[:id]).tournament
      current_user.unfollow!(@tournament)
      respond_with @tournament
  end

end
