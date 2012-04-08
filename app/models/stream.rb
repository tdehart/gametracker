# == Schema Information
#
# Table name: streams
#
#  id          :integer         not null, primary key
#  link        :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Stream < ActiveRecord::Base
  attr_accessible :description, :link, :streamers, :games

  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_many :events
  has_many :tournaments, :through => :events



  validates :link,        :presence => true
end
