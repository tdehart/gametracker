class FeedItem < ActiveRecord::Base
  attr_accessible :key, :owner, :recipient, :feedable

  belongs_to :feedable, :polymorphic => true
  belongs_to :owner, :polymorphic => true
  belongs_to :recipient, :polymorphic => true

  default_scope { where { key =~ "%create"} }
end
