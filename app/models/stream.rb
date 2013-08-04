# == Schema Information
#
# Table name: streams
#
#  id              :integer          not null, primary key
#  link            :string(255)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  channel_id      :string(255)
#  platform        :string(255)
#  viewer_count    :integer          default(0)
#  live            :boolean          default(FALSE)
#  current_game_id :integer
#  name            :string(255)
#

class Stream < ActiveRecord::Base
  has_and_belongs_to_many :streamers
  has_and_belongs_to_many :games
  has_and_belongs_to_many :events
  has_many :tournaments, :through => :events
  belongs_to :current_game, class_name: "Game", foreign_key: "current_game_id"

  before_save :sanitize_website, :find_channel_id

  validates :link, :presence => true

  mount_uploader :image, ImageUploader

  scope :live, lambda { where { {live => true } } }

  def to_s
    self.channel_id
  end

  def current_game_name
    current_game.try(:game_name)
  end

  def current_game_name=(game_name)
    self.current_game = Game.find_by_name(game_name) if game_name.present?
  end

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
