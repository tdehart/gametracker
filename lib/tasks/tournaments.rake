namespace :db do
  require 'csv'
  task tournaments: :environment do
    Event.delete_all
    Tournament.delete_all
    FollowedTournament.delete_all
    FeedItem.delete_all

    user = User.first

    csv_text = File.read("#{Rails.root}/app/assets/data/HotS-NoSeries-Tournaments.csv", :encoding => "windows-1251:utf-8")
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


    csv_text = File.read("#{Rails.root}/app/assets/data/HotS-Series-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://wiki.teamliquid.net/starcraft2/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[4],
                                         game_id: game.id,
                                         prize_pool: tournament[3].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: "#{tournament[0]} 2013",
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end

    game = Game.find_by_name("League of Legends")

    csv_text = File.read("#{Rails.root}/app/assets/data/LoL-2013-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://lol.gamepedia.com/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[3],
                                         game_id: game.id,
                                         prize_pool: tournament[2].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: "#{tournament[0]} 2013",
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end

    csv_text = File.read("#{Rails.root}/app/assets/data/LoL-Years-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://lol.gamepedia.com/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[3],
                                         game_id: game.id,
                                         prize_pool: tournament[2].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: tournament[0],
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end    
   
    game = Game.find_by_name("Dota 2")

    csv_text = File.read("#{Rails.root}/app/assets/data/Dota-2012-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://wiki.teamliquid.net/dota2/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[3],
                                         game_id: game.id,
                                         prize_pool: tournament[2].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: "#{tournament[0]} 2012",
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end

    csv_text = File.read("#{Rails.root}/app/assets/data/Dota-2013-Tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        @tournament = Tournament.create!(name: tournament[1],
                                         link: "http://wiki.teamliquid.net/dota2/" + tournament[1].split(" ").join("_"),
                                         num_competitors: tournament[3],
                                         game_id: game.id,
                                         prize_pool: tournament[2].tr("^0-9", ''),
                                         currency: "USD",
                                         chronic_start_input: "#{tournament[0]} 2013",
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end
  end
end