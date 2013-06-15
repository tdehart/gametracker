namespace :streams do
  task update: :environment do
    puts "Updating streams..."
    #s8f7nxieshjxy3wo1se8tsdbndm1ekv
    require 'httparty'

    Stream.all.each do |s|
      if s.platform == "twitch"
        result = HTTParty.get("https://api.twitch.tv/kraken/streams/#{s.channel_id}")
        status = result.response["status"]
        if status == "200 OK"
            #If stream is not null then it's live
            if result["stream"]
                viewers = result["stream"]["viewers"]
                gameName = result["stream"]["game"]
                #Find the current game by name, if nil then use first game that stream already has
                game = Game.find_by_name(gameName) || s.games[0]
                s.update_attributes(live: true, viewer_count: viewers, current_game: game)
                puts "#{s.link} is live with #{viewers} viewers. Current game is #{game.name}."
            else
                s.update_attribute(:live, false)
                puts "#{s.link} is not live"
            end
        else
          puts "#{s.link} could not be found. Status: #{status}"
        end
      end
    end
  end
end