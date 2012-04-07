FactoryGirl.define do
  factory :developer do
    name     "Example Developer"
    website  "http://www.exampledeveloper.com"
  end

  factory :game do
    name     "Example Game"
    website  "http://www.examplegame.com"
    genre    "Example Genre"
    players  100000
    developer
  end

  factory :tournament do
    name              "Example Tournament"
    link              "http://www.exampletournament.com"
    region            "USA"
    prize_pool        100000
    num_competitors   18
    tournament_date   Date.today
    stream_time       Time.now
    stream_link       "http://www.examplestreamlink.com"
    game
  end
end