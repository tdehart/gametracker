# == Schema Information
#
# Table name: streamers
#
#  id          :integer          not null, primary key
#  online_name :string(255)
#  real_name   :string(255)
#  nationality :string(255)
#  website     :string(255)
#  birthday    :date
#  biography   :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string(255)
#  slug        :string(255)
#

class Streamer < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :online_name, use: :slugged

  has_and_belongs_to_many :streams

  has_many :web_resources, :as => :resourceable

  validates :online_name,        :presence => true

  mount_uploader :image, ImageUploader

  def to_s
    self.online_name
  end
end
