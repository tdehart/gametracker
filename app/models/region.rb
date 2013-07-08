class Region < ActiveRecord::Base
  belongs_to :regionable, :polymorphic => true

  mount_uploader :image, ImageUploader
end
