class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_action :get_events, :get_streams

  def get_events
    #@sidebar_events = Event.soon
  end

  def get_streams
    @sidebar_streams = []
    Game.find_each do |g|
      Stream.where{ current_game_id == g.id }.order { viewer_count.desc }.includes(:current_game).take(3).each do |s|
        @sidebar_streams << s
      end
    end

    @sidebar_streams.sort! { |a,b| b.viewer_count <=> a.viewer_count }
  end
end
