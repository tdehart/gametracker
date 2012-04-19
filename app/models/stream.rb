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
  attr_accessible :description, :link, :streamers, :games, :game_ids, :streamer_ids

  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_many :events
  has_many :tournaments, :through => :events

  validates :link,      :presence => true
  validates :streamers, :presence => true
  validates :games,     :presence => true

  def to_s
    link
  end

  #own3d.tv (XML)
  #http://api.own3d.tv/liveCheck.php?live_id=123456

  #Justin.tv/Twitch.tv (JSON) - http://apiwiki.justin.tv/mediawiki/index.php/Stream/list
  #http://api.justin.tv/api/stream/list.json?channel=example_streamer
end
