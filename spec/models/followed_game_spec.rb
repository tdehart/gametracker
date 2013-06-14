# == Schema Information
#
# Table name: followed_games
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe FollowedGame do
  pending "add some examples to (or delete) #{__FILE__}"
end
