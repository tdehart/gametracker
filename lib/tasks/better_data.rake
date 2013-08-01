namespace :db do
  require 'chronic'
  require 'httparty'
  desc "Fill database with sample data"
  task better: :environment do
    Game.delete_all
    Developer.delete_all
    Event.delete_all
    Tournament.delete_all
    Streamer.delete_all
    Stream.delete_all
    FollowedTournament.delete_all
    FollowedGame.delete_all
    FeedItem.delete_all

    games = ["Starcraft II", "League of Legends", "Dota 2", "Ultimate Marvel vs. Capcom 3"]
    genres = ["Real-time strategy", "Action real-time strategy", "Action real-time strategy", "Fighting game"]
    games_images = ["http://i.imgur.com/s99COCk.png", "http://i.imgur.com/908QtoG.png", "http://i.imgur.com/1u7xQff.png", "http://i.imgur.com/QBsMVaw.png"]
    developers = ["Blizzard Entertainment", "Riot Games", "Valve", "Capcom"]
    developer_images = ["http://i.imgur.com/5eSLN0b.png", "http://i.imgur.com/XeIKvhO.jpg", "http://i.imgur.com/k4ysenH.png", "http://i.imgur.com/5CWcsb9.png"]
    developer_websites = ["http://www.blizzard.com", "http://www.riotgames.com", "http://www.valvesoftware.com/", "http://www.capcom.com/"]

    user = User.first

    #Create some developers
    developers.each do |d|
      Developer.create!(name: d,
                        remote_image_url: developer_images[developers.index(d)],
                        website: developer_websites[developers.index(d)]).id
    end

    #Create some games -- choose random developer
    games.each do |g|
      Game.create!(name: g,
                   developer_id: Developer.find_by_name(developers[games.index(g)]).id,
                   remote_image_url: games_images[games.index(g)],
                   genre: genres[games.index(g)])
    end


    

    games.each do |g|
      name = g.split(' ').join('+')
      streams = HTTParty.get("https://api.twitch.tv/kraken/streams/?game=#{name}").parsed_response["streams"]

      puts name

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

    

    # @tournament = Tournament.create!(name: "ESL Major Series X",
    #                                  link: "http://www.twitch.tv/esltv_studio1",
    #                                  num_competitors: 24,
    #                                  game_id: Game.first.id,
    #                                  prize_pool: 12000,
    #                                  currency: "USD",
    #                                  chronic_start_input: Date.today.to_s,
    #                                  chronic_end_input: (Date.today+30).to_s,
    #                                  description: "The ESL Major Series is a series of prize winning eSports tournaments hosted by Electronic Sports League.")

    # FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")

    # @event1 = @tournament.events.create(name: "Ro64",
    #                                     chronic_input: "in 1 hour",
    #                                     streams: [Stream.all.sample],
    #                                     description: "This is the event for Ro64")

    # @event2 = @tournament.events.create(name: "Ro32",
    #                                     chronic_input: "in 3 hours",
    #                                     streams: [Stream.all.sample],
    #                                     description: "This is the event for Ro32")

    # @event3 = @tournament.events.create(name: "Quarter Finals",
    #                                    chronic_input: "in 8 hours",
    #                                    streams: [Stream.all.sample],
    #                                    description: "This is the event for Quarter Finals")

    # FeedItem.create!(feedable: @event1, owner: user, key: "Event.create")
    # FeedItem.create!(feedable: @event2, owner: user, key: "Event.create")
    # FeedItem.create!(feedable: @event3, owner: user, key: "Event.create")

    # 99.times do
    #   name = Faker::Lorem.words(rand(3..5)).join(" ").capitalize
    #   link = "http://#{Faker::Internet.domain_name}"
    #   num_competitors = [8, 12, 24, 36, 48, 64, 128, 256, 512, 1024].sample
    #   game = Game.all.sample.id
    #   prize_pool = [2000, 4000, 8000, 12000, 24000, 48000, 64000, 80000, 100000, 200000, 500000, 1000000].sample
    #   date1 = 100.days.ago
    #   date2 = 100.days.ago+200.days
    #   start_date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f).to_date
    #   end_date = start_date+rand(1..30)
    #   description = Faker::Lorem.paragraphs(3).join()
    #   @tournament = Tournament.create!(name: name,
    #                                    link: link,
    #                                    num_competitors: num_competitors,
    #                                    game_id: game,
    #                                    prize_pool: prize_pool,
    #                                    currency: "USD",
    #                                    chronic_start_input: start_date.to_s,
    #                                    chronic_end_input: end_date.to_s,
    #                                    description: description)

    #   FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")

    #   (rand(4)+1).times do
    #     name = ["Ro256", "Ro128", "Ro64", "Ro32", "Ro16", "Ro8", "Quarter Finals", "Semi Finals", "Grand Finals"].sample
    #     day = [@tournament.start_date, @tournament.start_date+1, @tournament.start_date+2].sample
    #     time = %w[1pm 1:30pm 2pm 2:30pm 3pm 3:30pm 4pm 4:30pm 5pm 5:30pm 6pm 6:30pm 7pm 7:30pm 8pm].sample
    #     description = Faker::Lorem.paragraphs(3).join()

    #     stream = Stream.all.sample
    #     @event = @tournament.events.create(name: name,
    #                                        chronic_input: "#{day.to_s} at #{time}",
    #                                        streams: [stream],
    #                                        description: description)

    #     FeedItem.create!(feedable: @event, owner: user, key: "Event.create")
    #   end
    # end
  end
end