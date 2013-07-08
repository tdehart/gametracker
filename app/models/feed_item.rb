class FeedItem < ActiveRecord::Base
  belongs_to :feedable, :polymorphic => true
  belongs_to :owner, :polymorphic => true
  belongs_to :recipient, :polymorphic => true

  default_scope { where { key =~ "%create"} }
end
