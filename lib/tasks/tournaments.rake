namespace :db do
  require 'csv'
  task tournaments: :environment do
    Event.delete_all
    Tournament.delete_all
    FollowedTournament.delete_all
    FeedItem.delete_all

    user = User.first

    csv_text = File.read("#{Rails.root}/app/assets/data/tournaments.csv", :encoding => "windows-1251:utf-8")
    csv = CSV.parse(csv_text)

    csv.each do |tournament|
        puts "#{tournament[3]} #{tournament[4]} #{tournament[5]}"
        @tournament = Tournament.create!(name: tournament[3],
                                         link: tournament[7] ? tournament[7] : "http://www.google.com",
                                         num_competitors: tournament[6],
                                         game_id: Game.find_by_name(tournament[0]).id,
                                         prize_pool: tournament[4].tr("^0-9", ''),
                                         currency: tournament[5],
                                         chronic_start_input: "#{tournament[1]} #{tournament[2]}",
                                         description: Faker::Lorem.paragraphs(3).join())

        FeedItem.create!(feedable: @tournament, owner: user, key: "Tournament.create")
    end
  end
end