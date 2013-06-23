class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :get_events, :get_streams

  def get_events
    #@sidebar_events = Event.soon
  end

  def get_streams
    @sidebar_streams = []
    # @sidebar_streams = Stream.order { viewer_count.desc }.live
    # @sidebar_followed_streams = []
    # Stream.order { viewer_count.desc }.each do |s|
    #   if (current_user.games.include?(s.current_game))
    #     @sidebar_followed_streams << s
    #   end
    # end
  end
end
