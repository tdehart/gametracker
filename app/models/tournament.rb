# == Schema Information
#
# Table name: tournaments
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  link            :string(255)
#  region          :string(255)
#  start_date      :date
#  prize_pool      :integer
#  num_competitors :integer
#  game_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :string(255)
#  image           :string(255)
#

class Tournament < ActiveRecord::Base
  before_save :parse_chronic_inputs
  monetize :prize_pool_cents
  mount_uploader :image, ImageUploader

  belongs_to :game
  has_many :regions, :as => :regionable
  has_many :web_resources, :as => :resourceable

  has_many :users, through: :followed_tournaments
  has_many :followed_tournaments

  has_many :events, dependent: :destroy
  has_many :streams, through: :events

  has_many :feed_items, :as => :feedable
  
  validates :link,       :format => URI::regexp(%w(http https))
  validates :name,       :presence => true
  validates :prize_pool, :numericality => { greater_than_or_equal_to: 0, allow_nil: true }
  validates :game_id,    :presence => true
  #TODO: Write validator for region correctness
  #validates :region,          :presence =>     true

  #validates :num_competitors, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true },
  #                            :presence     => true

  #scope :soon, lambda { where { {start_date => Date.today-7..Date.today+7} }.order{ date.asc } }

  class << self
    def upcoming(h=24)
      events = Event.all(conditions: { event_time: h.hours.ago...Time.now }, order: "event_time DESC")

      tournaments = Hash.new
      #build list of tournaments and their upcoming events
      #events.map {|e| (tournaments[e.tournament] ||= [e]) << e}

      events.each do |e|
        if tournaments[e.tournament]
          tournaments[e.tournament] << e
        else
          tournaments[e.tournament] = [e]
        end
      end

      tournaments
    end
  end

  private
  def parse_chronic_inputs
    self.start_date = Chronic.parse(self.chronic_start_input) if self.chronic_start_input
    self.end_date = Chronic.parse(self.chronic_end_input) if self.chronic_end_input
  end
end
