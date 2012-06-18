class FollowedTournament < ActiveRecord::Base
  attr_accessible :tournament_id, :user_id
  belongs_to :user
  belongs_to :tournament
end
