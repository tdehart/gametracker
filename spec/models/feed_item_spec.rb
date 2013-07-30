# == Schema Information
#
# Table name: feed_items
#
#  id             :integer          not null, primary key
#  feedable_id    :integer
#  feedable_type  :string(255)
#  owner_id       :integer
#  owner_type     :string(255)
#  recipient_id   :integer
#  recipient_type :string(255)
#  key            :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe FeedItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
