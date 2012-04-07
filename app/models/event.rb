class Event < ActiveRecord::Base
  attr_accessible :date, :max_concurrent_viewers, :stream_id, :time, :tournament_id

  validates :tournament_id,          :presence => true
  validates :stream_id,              :presence => true
  validates :date,                   :presence => true
  validates :time,                   :presence => true
  validates :max_concurrent_viewers, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }

end
