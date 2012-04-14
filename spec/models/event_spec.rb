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

require 'spec_helper'

describe Event do

end
