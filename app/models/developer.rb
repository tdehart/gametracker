# == Schema Information
#
# Table name: developers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  website    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Developer < ActiveRecord::Base
  attr_accessible :name, :website

  has_many :games, :dependent => :destroy

  validates :name,    :presence => true,
                      :length   => { :maximum => 50 }

  validates :website, :presence => true,
                      :format   => { :with => VALID_LINK_REGEX}

end
