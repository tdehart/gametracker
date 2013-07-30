namespace :db do
  require 'chronic'
  desc "Fill database with sample data"
  task populate: :environment do
    Game.delete_all
    Developer.delete_all
    Event.delete_all
    Tournament.delete_all
    Streamer.delete_all
    Stream.delete_all
    FollowedTournament.delete_all
    FollowedGame.delete_all
    FeedItem.delete_all

    genres = ["RTS", "FPS", "ARTS"]
    games = ["Starcraft II", "League of Legends", "Starcraft: Brood War", "Dota 2", "Team Fortress 2", "Counter-Strike Source", "Quake Live", "Call of Duty 4", "Heroes of Newerth"]
    game_developers = ["Blizzard", "Riot Games", "Blizzard", "Valve", "Valve", "Valve", "id Software", "Infinity Ward", "S2 Games"]
    developers = ["Blizzard", "Riot Games", "Valve", "id Software", "Infinity Ward", "S2 Games"]
    user = User.first

    #Create some developers
    developers.each do |d|
      Developer.create!(name: d,
                        website: "http://www.google.com")
    end

    #Create some games -- choose random developer
    games.each do |g|
      
      Game.create!(name: g,
                   website: "http://www.google.com",
                   genre: genres.sample,
                   developer_id: Developer.find_by_name(game_developers[games.index(g)]).id)
    end

    #Create some fake streamers
    99.times do
      online_name = Faker::Name.first_name
      real_name = Faker::Name.name
      website = "http://#{Faker::Internet.domain_name}"
      birthday = rand(30.years).ago
      Streamer.create!(online_name: online_name,
                       real_name: real_name,
                       website: website,
                       birthday: birthday)
    end

    streams = ["http://www.twitch.tv/tsm_theoddone", "http://www.twitch.tv/tsm_reginald", "http://www.twitch.tv/crs_saintvicious", "http://www.twitch.tv/mylonzete", "http://www.twitch.tv/dreamhacksc2", "http://www.twitch.tv/idrajit", "http://www.twitch.tv/towelliee"]
    #Create some streams -- use random streamers
    streams.each do |s|
      link = s
      game = Game.all.sample
      streamer = Streamer.all.sample
      Stream.create!(link: link,
                     games: [game],
                     streamers: [streamer],
                     current_game: game)
    end

    @tournament = Tournament.create!(name: "ESL Major Series X",
                                     link: "http://www.twitch.tv/esltv_studio1",
                                     num_competitors: 24,
                                     game_id: Game.first.id,
                                     prize_pool: 12000,
                                     currency: "USD",
                                     chronic_start_input: Date.today.to_s,
                                     chronic_end_input: (Date.today+30).to_s,
                                     description: "The ESL Major Series is a series of prize winning eSports tournaments hosted by Electronic Sports League.")

    FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")

    @event1 = @tournament.events.create(name: "Ro64",
                                        chronic_input: "in 1 hour",
                                        streams: [Stream.all.sample],
                                        description: "This is the event for Ro64")

    @event2 = @tournament.events.create(name: "Ro32",
                                        chronic_input: "in 3 hours",
                                        streams: [Stream.all.sample],
                                        description: "This is the event for Ro32")

    @event3 = @tournament.events.create(name: "Quarter Finals",
                                       chronic_input: "in 8 hours",
                                       streams: [Stream.all.sample],
                                       description: "This is the event for Quarter Finals")

    FeedItem.create!(feedable: @event1, owner: user, key: "Event.create")
    FeedItem.create!(feedable: @event2, owner: user, key: "Event.create")
    FeedItem.create!(feedable: @event3, owner: user, key: "Event.create")

    99.times do
      name = Faker::Lorem.words(rand(3..5)).join(" ").capitalize
      link = "http://#{Faker::Internet.domain_name}"
      num_competitors = [8, 12, 24, 36, 48, 64, 128, 256, 512, 1024].sample
      game = Game.all.sample.id
      prize_pool = [2000, 4000, 8000, 12000, 24000, 48000, 64000, 80000, 100000, 200000, 500000, 1000000].sample
      date1 = 100.days.ago
      date2 = 100.days.ago+200.days
      start_date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f).to_date
      end_date = start_date+rand(1..30)
      description = Faker::Lorem.paragraphs(3).join()
      @tournament = Tournament.create!(name: name,
                                       link: link,
                                       num_competitors: num_competitors,
                                       game_id: game,
                                       prize_pool: prize_pool,
                                       currency: "USD",
                                       chronic_start_input: start_date.to_s,
                                       chronic_end_input: end_date.to_s,
                                       description: description)

      FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")

      (rand(4)+1).times do
        name = ["Ro256", "Ro128", "Ro64", "Ro32", "Ro16", "Ro8", "Quarter Finals", "Semi Finals", "Grand Finals"].sample
        day = [@tournament.start_date, @tournament.start_date+1, @tournament.start_date+2].sample
        time = %w[1pm 1:30pm 2pm 2:30pm 3pm 3:30pm 4pm 4:30pm 5pm 5:30pm 6pm 6:30pm 7pm 7:30pm 8pm].sample
        description = Faker::Lorem.paragraphs(3).join()

        stream = Stream.all.sample
        @event = @tournament.events.create(name: name,
                                           chronic_input: "#{day.to_s} at #{time}",
                                           streams: [stream],
                                           description: description)

        FeedItem.create!(feedable: @event, owner: user, key: "Event.create")
      end
    end
  end
end