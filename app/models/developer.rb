class Developer < ActiveRecord::Base
  attr_accessible :name, :website

  validates :name,  :presence => true,
            :length => { :maximum => 50 }

  validates :website,  :presence => true,
            :length => { :maximum => 50 }
end
