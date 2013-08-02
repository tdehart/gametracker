namespace :db do
  require 'httparty'
  task streams: :environment do
    Streamer.delete_all
    Stream.delete_all

    games = ["StarCraft II: Heart of the Swarm", "League of Legends", "Dota 2", "Ultimate Marvel vs. Capcom 3"]

    games.each do |g|
      name = g.split(' ').join('+')
      streams = HTTParty.get("https://api.twitch.tv/kraken/streams/?game=#{name}", headers: { "Client-ID" => ENV["TWITCH-ID"] }).parsed_response["streams"]

      streams.each do |s|
        channel = s["channel"]
        link = channel["url"]
        image = channel["logo"]
        game = Game.find_by_name(channel["game"])
        online_name = channel["display_name"]
        viewers = s["viewers"]

        streamer = Streamer.create!(online_name: online_name,
                                    remote_image_url: image)

        Stream.create!(link: link,
                       games: [game],
                       current_game: game,
                       streamers: [streamer],
                       live: viewers == 0 ? false : true,
                       viewer_count: viewers)
      end
    end
  end
end