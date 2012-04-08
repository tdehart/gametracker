# == Schema Information
#
# Table name: events
#
#  id                     :integer         not null, primary key
#  tournament_id          :integer
#  stream_id              :integer
#  date                   :date
#  time                   :time
#  max_concurrent_viewers :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

class Event < ActiveRecord::Base
  attr_accessible :date, :max_concurrent_viewers, :stream_id, :time, :tournament_id

  belongs_to :tournament
  belongs_to :stream

  validates :tournament_id,          :presence => true
  validates :stream_id,              :presence => true
  validates :date,                   :presence => true
  validates :time,                   :presence => true
  validates :max_concurrent_viewers, :numericality => { :greater_than_or_equal_to => 0, :allow_nil => true }

end
