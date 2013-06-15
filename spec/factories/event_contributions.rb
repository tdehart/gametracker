# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_contribution do
    event_id 1
    contributor_id 1
    submitter false
  end
end
