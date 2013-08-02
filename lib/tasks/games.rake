namespace :db do
  task games: :environment do
    Game.delete_all
    Developer.delete_all
    FollowedGame.delete_all

    games = ["StarCraft II: Heart of the Swarm", "League of Legends", "Dota 2", "Ultimate Marvel vs. Capcom 3"]
    abbrevs = ["SC2", "LoL", "Dota 2", "UMvC3"]
    genres = ["Real-time strategy", "Action real-time strategy", "Action real-time strategy", "Fighting game"]
    comp_type = ["players", "teams", "teams", "players"]
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
      index = games.index(g)
      Game.create!(name: g,
                   developer_id: Developer.find_by_name(developers[index]).id,
                   remote_image_url: games_images[index],
                   genre: genres[index],
                   competitor_type: comp_type[index],
                   abbreviation: abbrevs[index])
    end
  end
end