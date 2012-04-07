# == Schema Information
#
# Table name: tournaments
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  link            :string(255)
#  region          :string(255)
#  date            :date
#  prize_pool      :integer
#  num_competitors :integer
#  game_id         :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Tournament < ActiveRecord::Base
  attr_accessible :game_id, :link, :name, :num_competitors, :prize_pool, :region, :stream_link, :stream_time, :tournament_date

  belongs_to :game

  validates :link,            :presence =>     true,
                              :format   =>     { :with => VALID_LINK_REGEX }

  validates :name,            :presence =>     true

  validates :region,          :presence =>     true

  validates :prize_pool,      :numericality => { :greater_than_or_equal_to => 0 }

  validates :game_id,         :presence =>     true

  validates :tournament_date, :presence =>     true

  validates :prize_pool,      :presence =>     true

  validates :num_competitors, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }

end
