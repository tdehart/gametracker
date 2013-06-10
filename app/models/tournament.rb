# == Schema Information
#
# Table name: tournaments
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  link            :string(255)
#  region          :string(255)
#  start_date      :date
#  prize_pool      :integer
#  num_competitors :integer
#  game_id         :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  description     :string(255)
#

class Tournament < ActiveRecord::Base
  attr_accessible :game_id, :link, :name, :num_competitors, :prize_pool, :region, :start_date, :description, :image, :remote_image_url

  belongs_to :game

  has_many :users, through: :followed_tournaments
  has_many :followed_tournaments

  has_many :tournament_contributions, :dependent => :destroy
  has_many :contributors, :through => :tournament_contributions, :source => :contributor, :uniq => true, :class_name => "User"
    
  has_many :events, dependent: :destroy
  has_many :streams, through: :events
  #accepts_nested_attributes_for :events#, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates :link,            :format => URI::regexp(%w(http https)),
                              :presence =>     true

  validates :name,            :presence =>     true

  #TODO: Write validator for region correctness
  #validates :region,          :presence =>     true

  validates :prize_pool,      :numericality => { greater_than_or_equal_to: 0, allow_nil: true }

  validates :game_id,         :presence =>     true

  validates :start_date,            :presence =>     true



  #validates :prize_pool,      :presence =>     true

  #validates :num_competitors, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true },
  #                            :presence     => true

  #scope :soon, lambda { where { {start_date => Date.today-7..Date.today+7} }.order{ date.asc } }

  mount_uploader :image, ImageUploader

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

    def notable

    end
  end
end
