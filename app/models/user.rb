# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string(255)
#  remember_token    :string(255)
#  admin             :boolean          default(FALSE)
#  currency_iso_code :string(255)
#

class User < ActiveRecord::Base
  has_secure_password

  before_save { email.downcase! }
  before_save :create_remember_token
  before_create :default_currency

  validates :name, presence: true, length: { maximum: 30 }, on: :create
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_many :feed_items_as_owner, :class_name => "FeedItem", :as => :owner
  has_many :feed_items_as_recipient, :class_name => "FeedItem", :as => :recipient

  has_many :tournaments, through: :followed_tournaments
  has_many :followed_tournaments, dependent: :destroy
  has_many :games, through: :followed_games
  has_many :followed_games, dependent: :destroy
  
  #Get all tournaments of followed games and any followed tournaments
  #Remove duplicates and sort by created_at
  def feed
    if self.games
      u = User.find(self)
      game_ids = u.games.pluck(:id)
      tournament_ids = u.tournaments.pluck(:id)

      @tournaments = Tournament.where { (game_id.in(game_ids)) | (id.in(tournament_ids)) }
      @events = Event.where { tournament_id.in(my{@tournaments.pluck(:id)}) }

      #Get all tournament and event feed_items
      #Hint: Use my{} to interpolate instance variables with squeel
      # FeedItem.where{ (feedable_id.in(my{@tournaments.ids}) & feedable_type.eq('Tournament')) | 
      #                 (feedable_id.in(my{@events.ids}) & feedable_type.eq('Event')) }.includes(:games).includes(:owner).order { created_at.desc }
      tournament_feed = FeedItem.where{ (feedable_id.in(my{@tournaments.ids}) & feedable_type.eq('Tournament')) }.includes(:owner).includes(:feedable => :game)
      event_feed = FeedItem.where{ (feedable_id.in(my{@events.ids}) & feedable_type.eq('Event')) }

      tournament_feed + event_feed
    end


    
  end

  def following?(object)
    if object.is_a?(Tournament)
      followed_tournaments.find_by_tournament_id(object.id)
    elsif object.is_a?(Game)
      followed_games.find_by_game_id(object.id)
    end
  end

  def follow!(object)
    if object.is_a?(Tournament)
      followed_tournaments.create!(tournament_id: object.id)
    elsif object.is_a?(Game)
      followed_games.create!(game_id: object.id)
    end
  end

  def unfollow!(object)
    if object.is_a?(Tournament)
      followed_tournaments.find_by_tournament_id(object.id).destroy
    elsif object.is_a?(Game)
      followed_games.find_by_game_id(object.id).destroy
    end
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def default_currency
    self.currency_iso_code = "USD"
  end
end


