# == Schema Information
#
# Table name: events
#
#  id                     :integer          not null, primary key
#  tournament_id          :integer
#  stream_id              :integer
#  max_concurrent_viewers :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  event_time             :datetime
#  description            :text
#  chronic_input          :string(255)
#

class Event < ActiveRecord::Base
  before_save :parse_chronic_input

  belongs_to :tournament
  has_and_belongs_to_many :streams
  has_many :web_resources, :as => :resourceable
  has_many :feed_items, :as => :feedable

  validates :name,       :presence => {:message => "can't be blank"}
  validates :chronic_input, :presence => true
  #validates :max_concurrent_viewers, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }

  #All events happening between 6 hours ago and 36 hours from now ordered by start time
  scope :current, -> { where(event_time: 6.hours.ago..36.hours.from_now).order { event_time.asc } }
  scope :soon, -> { where(event_time: 37.hours.from_now..5.days.from_now).order { event_time.asc } }

  private
  def parse_chronic_input
    self.event_time = Chronic.parse(self.chronic_input)
  end
  
end
