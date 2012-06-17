class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :get_events, :get_streams

  def get_events
    @sidebar_events = Event.soon
  end

  def get_streams
    @sidebar_streams = Stream.live
  end


end
