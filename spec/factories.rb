FactoryGirl.define do
  factory :developer do
    name     "Example Developer"
    website  "http://www.exampledeveloper.com"
  end

  factory :game do
    name         "Example Game"
    website      "http://www.examplegame.com"
    genre        "Example Genre"
    num_players  100000
    developer
  end

  factory :tournament do
    name              "Example Tournament"
    link              "http://www.exampletournament.com"
    region            "USA"
    prize_pool        100000
    num_competitors   18
    date              Date.today
    game
  end

  factory :streamer do
    online_name "Example Online Name"
    real_name   "Example Real Name"
    website     "http://www.examplewebsite.com"
    biography   "Example Biography"
    birthday    Date.today
    nationality "American"
  end

  factory :stream do
    link        "http://www.examplestreamlink.com"
    description "Example Description"
  end

end