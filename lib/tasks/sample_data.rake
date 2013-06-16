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
    TournamentContribution.delete_all
    EventContribution.delete_all

    developers = ["Blizzard Entertainment", "Valve", "Riot Games", "S2 Games", "id Software"]
    genres = ["RTS", "FPS", "ARTS"]
    games = ["Starcraft II", "League of Legends", "Starcraft: Brood War", "Dota 2", "Team Fortress 2", "Counter-Strike Source", "Quake Live", "Call of Duty 4", "Heroes of Newerth"]
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
                   developer_id: Developer.all.sample.id)
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
                                     region: "US",
                                     num_competitors: 24,
                                     game_id: Game.first.id,
                                     prize_pool: 12000,
                                     start_date: Date.today,
                                     description: "The ESL Major Series is a series of prize winning eSports tournaments hosted by Electronic Sports League.")
    user.submit!(@tournament)

    @event1 = @tournament.events.create(name: "Ro64",
                                        event_time: Chronic.parse("in 1 hour").to_datetime,
                                        stream_id: Stream.all.sample.id,
                                        description: "This is the event for Ro64")

    @event2 = @tournament.events.create(name: "Ro32",
                                        event_time: Chronic.parse("in 3 hours").to_datetime,
                                        stream_id: Stream.all.sample.id,
                                        description: "This is the event for Ro32")

    @event3 =@tournament.events.create(name: "Quarter Finals",
                                       event_time: Chronic.parse("in 8 hours").to_datetime,
                                       stream_id: Stream.all.sample.id,
                                       description: "This is the event for Quarter Finals")

    user.submit!(@event1)
    user.submit!(@event2)
    user.submit!(@event3)

    99.times do
      name = Faker::Lorem.words(rand(3..5)).join(" ").capitalize
      link = "http://#{Faker::Internet.domain_name}"
      region = %w[US EU Asia International].sample
      num_competitors = [8, 12, 24, 36, 48, 64, 128, 256, 512, 1024].sample
      game = Game.all.sample.id
      prize_pool = [2000, 4000, 8000, 12000, 24000, 48000, 64000, 80000, 100000, 200000, 500000, 1000000].sample
      date1 = 100.days.ago
      date2 = 100.days.ago+200.days
      start_date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f).to_date
      description = Faker::Lorem.paragraphs(3).join()
      @tournament = Tournament.create!(name: name,
                                       link: link,
                                       region: region,
                                       num_competitors: num_competitors,
                                       game_id: game,
                                       prize_pool: prize_pool,
                                       start_date: start_date,
                                       description: description)

      user.submit!(@tournament)

      (rand(4)+1).times do
        name = ["Ro256", "Ro128", "Ro64", "Ro32", "Ro16", "Ro8", "Quarter Finals", "Semi Finals", "Grand Finals"].sample
        day = [@tournament.start_date, @tournament.start_date+1, @tournament.start_date+2].sample
        time = Chronic.parse(%w[1pm 1:30pm 2pm 2:30pm 3pm 3:30pm 4pm 4:30pm 5pm 5:30pm 6pm 6:30pm 7pm 7:30pm 8pm].sample, :now => day).to_datetime
        description = Faker::Lorem.paragraphs(3).join()

        stream = Stream.all.sample.id
        @event = @tournament.events.create(name: name,
                                           event_time: time,
                                           stream_id: stream,
                                           description: description)
        user.submit!(@event)
      end
    end
  end
end