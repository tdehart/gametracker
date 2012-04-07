# == Schema Information
#
# Table name: games
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  website      :string(255)
#  genre        :string(255)
#  num_players  :integer
#  developer_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Game < ActiveRecord::Base
  attr_accessible :genre, :name, :num_players, :website, :developer_id

  belongs_to :developer
  has_many :tournaments, :dependent => :destroy

  validates :name,         :presence     => true,
                           :length       => { :maximum => 50 }

  validates :genre,        :presence     => true,
                           :length       => { :maximum => 20 }

  validates :website,      :format       => { :with => VALID_LINK_REGEX }

  validates :developer_id, :presence     => true

  validates :num_players,  :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }
end
