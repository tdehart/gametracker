class Streamer < ActiveRecord::Base
  attr_accessible :biography, :birthday, :nationality, :online_name, :real_name, :website

  validates :online_name,        :presence => true

  validates :website,            :format   => { :with => VALID_LINK_REGEX, :allow_blank => true }
end
