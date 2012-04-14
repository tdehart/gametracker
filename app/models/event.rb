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
#  name                   :string(255)
#

class Event < ActiveRecord::Base
  attr_accessible :date, :max_concurrent_viewers, :stream_id, :time, :tournament_id, :name

  belongs_to :tournament
  belongs_to :stream
end
