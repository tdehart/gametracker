class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_events, :get_streams

  def get_events
    @sidebar_events = Event.soon
  end

  def get_streams

    #TODO: Move to delayed job and update the model
    @streams = Stream.all
    #@streams.each do |s|
    #  link = s.link
    #  if link.index("twitch.tv") || link.index("justin.tv")
    #    require 'open-uri'
    #    streamer_id = link.split("/")[3]
    #    result = JSON.parse(open("http://api.justin.tv/api/stream/list.json?channel=#{streamer_id}").read)[0]
    #    if result
    #      embed_count = result["embed_count"]
    #      stream_count = result["stream_count"]
    #      channel_count = result["channel_count"]
    #    end
    #  elsif link.index("own3d.tv")
    #    require "rexml/document"
    #    streamer_id = link.split("/")[4]
    #    xml = Net::HTTP.get_response(URI.parse("http://api.own3d.tv/liveCheck.php?live_id=#{streamer_id}"))
    #    doc = REXML::Document.new(xml.body)
    #    is_live = doc.root.elements["liveEvent/isLive"].text
    #    viewer_count = doc.root.elements["liveEvent/liveViewers"].text
    #  end
    #end

    @sidebar_streams = @streams
  end
end
