# == Schema Information
#
# Table name: streamers
#
#  id          :integer         not null, primary key
#  online_name :string(255)
#  real_name   :string(255)
#  nationality :string(255)
#  website     :string(255)
#  birthday    :date
#  biography   :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Streamer < ActiveRecord::Base
  attr_accessible :biography, :birthday, :nationality, :online_name, :real_name, :website, :streams

  has_and_belongs_to_many :streams

  validates :online_name,        :presence => true

  validates :website,            :format   => { :with => VALID_LINK_REGEX, :allow_blank => true }
end
