# == Schema Information
#
# Table name: tournament_contributions
#
#  id             :integer          not null, primary key
#  tournament_id  :integer
#  contributor_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  submitter      :boolean
#

class TournamentContribution < ActiveRecord::Base
  attr_accessible :contributor_id, :tournament_id, :submitter

  belongs_to :contributor, class_name: 'User'
  belongs_to :tournament
end
