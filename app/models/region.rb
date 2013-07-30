# == Schema Information
#
# Table name: regions
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  image           :string(255)
#  regionable_id   :integer
#  regionable_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Region < ActiveRecord::Base
  belongs_to :regionable, :polymorphic => true

  mount_uploader :image, ImageUploader
end
