namespace :streams do
  desc "This task is called by the Heroku scheduler add-on"
  task update: :environment do
    puts "Updating streams..."
    #s8f7nxieshjxy3wo1se8tsdbndm1ekv
    # require "rexml/document"
    # require "open-uri"

    # Stream.all.each do |s|
    #   if s.platform == "justin"
    #     result = JSON.parse(open("http://api.justin.tv/api/stream/list.json?channel=#{s.channel_id}").read)[0]
    #     if result
    #       viewers = result["channel_count"]
    #       s.update_attributes(live: true, viewer_count: viewers)
    #     else
    #       s.update_attribute(:live, false)
    #     end
    #   end
    # end

    puts "done."
  end
end