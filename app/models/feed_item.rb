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

class FeedItem < ActiveRecord::Base
  belongs_to :feedable, :polymorphic => true
  belongs_to :owner, :polymorphic => true
  belongs_to :recipient, :polymorphic => true

  default_scope { where { key =~ "%create"} }
end
