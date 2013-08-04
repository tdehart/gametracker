namespace :db do
  require 'httparty'
  task streams: :environment do
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
        display_name = channel["display_name"]
        viewers = s["viewers"]

        Stream.create!(name: display_name,
                       link: link,
                       games: [game],
                       current_game: game,
                       live: viewers == 0 ? false : true,
                       viewer_count: viewers,
                       remote_image_url: image)
      end
    end
  end
end