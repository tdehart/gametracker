class Region < ActiveRecord::Base
  attr_accessible :image, :name, :regionable_id, :regionable_type, :remote_image_url

  belongs_to :regionable, :polymorphic => true

  mount_uploader :image, ImageUploader
end
