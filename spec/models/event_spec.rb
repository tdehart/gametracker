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

require 'spec_helper'

describe Event do

end
