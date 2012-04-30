desc "This task is called by the Heroku scheduler add-on"
task :update_stream_stats => :environment do
  puts "Updating streams..."

  require "rexml/document"
  require "open-uri"

  Stream.all.each do |s|
    if s.platform == "justin"
      result = JSON.parse(open("http://api.justin.tv/api/stream/list.json?channel=#{s.channel_id}").read)[0]
      if result
        viewers = result["channel_count"]
        s.update_attributes(live: true, viewer_count: viewers)
      else
        s.update_attribute(:live, false)
      end
    elsif s.platform == "own3d"
      xml = Net::HTTP.get_response(URI.parse("http://api.own3d.tv/liveCheck.php?live_id=#{s.channel_id}"))
      doc = REXML::Document.new(xml.body)
      is_live = doc.root.elements["liveEvent/isLive"].text
      if is_live == "true"
        viewers = doc.root.elements["liveEvent/liveViewers"].text.to_i
        s.update_attributes(live: true, viewer_count: viewers)
      else
        s.update_attribute(:live, false)
      end
    end
  end

  puts "done."
end