namespace :streams do
  task update: :environment do
    puts "Updating streams..."
    require 'httparty'

    stream_names = Stream.all.map(&:channel_id).join(',')

    result = HTTParty.get("https://api.twitch.tv/kraken/streams?channel=#{stream_names}", headers: { "Client-ID" => ENV["TWITCH-ID"] })

    status = result.response["status"]

    if status == "200 OK"
        streams = result.parsed_response["streams"]
        streams.each do |s|
            channel = s["channel"]
            link = channel["url"]
            image = channel["logo"]
            game = Game.find_by_name(channel["game"])
            display_name = channel["display_name"]
            viewers = s["viewers"]

            stream = Stream.find_by_link(link)

            if stream
                stream.update_attributes(name: display_name,
                                 current_game: game,
                                 live: viewers == 0 ? false : true,
                                 viewer_count: viewers,
                                 remote_image_url: image) unless stream.nil?
                # puts "Updated #{stream.channel_id} with #{viewers} viewers. Stream game is #{game.name}"
            else
                puts "#{channel} not updated, record not found."
            end

            
        end
    else
      puts "Error accessing Twitch: #{status}"
    end
  end
end