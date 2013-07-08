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

class FollowedTournament < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
end
