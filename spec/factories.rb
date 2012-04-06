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
end