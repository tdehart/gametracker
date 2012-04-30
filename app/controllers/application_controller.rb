class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_events, :get_streams

  def get_events
    @sidebar_events = Event.soon
  end

  def get_streams

    #TODO: Move to delayed job and update the model
    @streams = Stream.where { live == true }
    @sidebar_streams = @streams
  end
end
