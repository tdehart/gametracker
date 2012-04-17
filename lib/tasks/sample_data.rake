namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Tournament.delete_all

    Tournament.create!(name: "ESL Major Series X",
                       link: "http://www.twitch.tv/esltv_studio1",
                       region: "US",
                       num_competitors: 24,
                       game_id: Game.find_by_name("League of Legends"),
                       prize_pool: 12000,
                       date: Date.today,
                       description: "The ESL Major Series is a series of prize winning eSports tournaments hosted by Electronic Sports League.")
    99.times do |n|
      name = Faker::Lorem.words(rand(3..5)).join(" ").capitalize
      link = "http://#{Faker::Internet.domain_name}"
      region = %w[US EU Asia International].sample
      num_competitors = [8, 12, 24, 36, 48, 64, 128, 256, 512, 1024].sample
      game = Game.all.sample.id
      prize_pool = [2000, 4000, 8000, 12000, 24000, 48000, 64000, 80000, 100000, 200000, 500000, 1000000].sample
      date1 = 100.days.ago
      date2 = 100.days.ago+200.days
      date = Time.at((date2.to_f - date1.to_f)*rand + date1.to_f).to_date
      description = Faker::Lorem.paragraph
      Tournament.create!(name: name,
                         link: link,
                         region: region,
                         num_competitors: num_competitors,
                         game_id: game,
                         prize_pool: prize_pool,
                         date: date,
                         description: description)
    end
  end
end