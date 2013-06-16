# == Schema Information
#
# Table name: streams
#
#  id           :integer          not null, primary key
#  link         :string(255)
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  channel_id   :string(255)
#  platform     :string(255)
#  viewer_count :integer          default(0)
#  live         :boolean          default(FALSE)
#

class Stream < ActiveRecord::Base
  attr_accessible :description, :link, :streamers, :games, :game_ids, :streamer_ids, :live, :viewer_count, :channel_id, :live, :platform, :current_game

  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_many :events
  has_many :tournaments, :through => :events
  belongs_to :current_game, class_name: "Game", foreign_key: "current_game_id"

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
    if link.index("twitch.tv")
      id = link.split("/")[3].split("?")[0]
      self.channel_id = id
      self.platform = "twitch"
      self.link = "http://www.twitch.tv/#{id}"
    else
      raise "Streaming platform not supported. Please provide a justin.tv or twitch.tv link."    
    end
  end
end
