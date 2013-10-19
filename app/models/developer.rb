# == Schema Information
#
# Table name: developers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  website    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :string(255)
#  slug       :string(255)
#

class Developer < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :games, :dependent => :destroy

  validates :name,    :presence => true,
                      :length   => { :maximum => 50 }

  validates :website, :presence => true

  mount_uploader :image, ImageUploader
end
