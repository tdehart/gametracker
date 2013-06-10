class TournamentContribution < ActiveRecord::Base
  attr_accessible :contributor_id, :tournament_id, :submitter

  belongs_to :contributor, class_name: 'User'
  belongs_to :tournament
end
