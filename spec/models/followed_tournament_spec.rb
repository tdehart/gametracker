# == Schema Information
#
# Table name: followed_tournaments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  tournament_id :integer
#  hidden        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe FollowedTournament do
  pending "add some examples to (or delete) #{__FILE__}"
end
