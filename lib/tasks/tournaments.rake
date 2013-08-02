namespace :db do
  require 'csv'
  task tournaments: :environment do
    Event.delete_all
    Tournament.delete_all
    FollowedTournament.delete_all
    FollowedGame.delete_all
    FeedItem.delete_all

    user = User.first

    csv_text = File.read("#{Rails.root}/app/assets/data/HotS-Series-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    game = Game.find_by_name("StarCraft II: Heart of the Swarm")
    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://wiki.teamliquid.net/starcraft2/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[3],
                                         game_id: game.id,
                                         prize_pool: tournament[2].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: "#{tournament[0]} 2013",
                                         description: Faker::Lorem.paragraphs(3).join())
        
        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end
   

    

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