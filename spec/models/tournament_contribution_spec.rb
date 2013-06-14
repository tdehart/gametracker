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

require 'spec_helper'

describe TournamentContribution do
  pending "add some examples to (or delete) #{__FILE__}"
end
