class EventContribution < ActiveRecord::Base
  attr_accessible :contributor_id, :event_id, :submitter

  belongs_to :contributor, class_name: 'User'
  belongs_to :event
end
