# == Schema Information
#
# Table name: events
#
#  id                     :integer         not null, primary key
#  tournament_id          :integer
#  stream_id              :integer
#  max_concurrent_viewers :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  name                   :string(255)
#  event_time             :datetime
#

class Event < ActiveRecord::Base
  attr_accessible :max_concurrent_viewers, :stream_id, :event_time, :tournament_id, :name

  belongs_to :tournament
  belongs_to :stream

  validates :name,       :presence => {:message => "can't be blank"}
  validates :stream_id,  :presence => {:message => "can't be blank"}
  validates :event_time, :presence => true
  #validates :max_concurrent_viewers, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }

  default_scope { order { event_time.asc } }
  scope :soon, lambda { where { {event_time => Time.now-2.hours..Date.today+2} }.order { event_time.asc } }
end
