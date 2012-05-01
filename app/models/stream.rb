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
  attr_accessible :description, :link, :streamers, :games, :game_ids, :streamer_ids, :live, :viewer_count, :channel_id

  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_many :events
  has_many :tournaments, :through => :events

  before_create :find_channel_id

  validates :link, :presence => true
  validates :streamers, :presence => true
  validates :games, :presence => true

  private
  def find_channel_id
    if link.index("twitch.tv") || link.index("justin.tv")
      self.channel_id = link.split("/")[3]
      self.platform = "justin"
    elsif link.index("own3d.tv")
      self.channel_id = link.split("/")[4]
      self.platform = "own3d"
    else
      raise "Streaming platform not supported. Please provide a justin.tv, twitch.tv, or own3d.tv link"
    end
  end

end