# == Schema Information
#
# Table name: tournaments
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  link            :string(255)
#  region          :string(255)
#  date            :date
#  prize_pool      :integer
#  num_competitors :integer
#  game_id         :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  description     :string(255)
#

class Tournament < ActiveRecord::Base
  attr_accessible :game_id, :link, :name, :num_competitors, :prize_pool, :region, :date, :description, :image, :remote_image_url, :events_attributes

  belongs_to :game
  has_many :users, through: :followed_tournaments
  has_many :followed_tournaments
  has_many :events, dependent: :destroy
  has_many :streams, through: :events
  accepts_nested_attributes_for :events#, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates :link,            :format   =>     { :with => VALID_LINK_REGEX },
                              :presence =>     true

  validates :name,            :presence =>     true

  #TODO: Write validator for region correctness
  validates :region,          :presence =>     true

  validates :prize_pool,      :numericality => { :greater_than_or_equal_to => 0 }

  validates :game_id,         :presence =>     true

  validates :date,            :presence =>     true

  validates :prize_pool,      :presence =>     true

  validates :num_competitors, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true },
                              :presence     => true

  scope :soon, lambda { where { {date => Date.today-7..Date.today+7} }.order{ date.asc } }

  mount_uploader :image, ImageUploader

end
