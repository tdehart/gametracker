# == Schema Information
#
# Table name: streams
#
#  id           :integer         not null, primary key
#  link         :string(255)
#  description  :text
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  channel_id   :string(255)
#  platform     :string(255)
#  viewer_count :integer         default(0)
#  live         :boolean         default(FALSE)
#

class Stream < ActiveRecord::Base
  attr_accessible :description, :link, :streamers, :games, :game_ids, :streamer_ids, :live, :viewer_count, :channel_id

  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_many :events
  has_many :tournaments, :through => :events

  before_create :sanitize_website, :find_channel_id

  validates :link, :presence => true
  validates :streamers, :presence => true
  validates :games, :presence => true

  scope :live, lambda { where { {live => true } } }

  private
  def sanitize_website
    unless self.link.include?("http://") || self.website.include?("https://")
      self.website = "http://" + self.website
    end
  end

  def find_channel_id
    if link.index("twitch.tv") || link.index("justin.tv")
      id = link.split("/")[3].split("?")[0]
      self.channel_id = id
      self.platform = "justin"
      self.link = "http://www.twitch.tv/#{id}"
    elsif link.index("own3d.tv")
      id = link.split("/")[5]
      self.channel_id = id
      self.platform = "own3d"
      self.link = "http://www.own3d.tv/live/#{id}"
    else
      raise "Streaming platform not supported. Please provide a justin.tv, twitch.tv, or own3d.tv link"
    end
  end
end
