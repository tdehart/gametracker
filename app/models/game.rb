# == Schema Information
#
# Table name: games
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  website      :string(255)
#  genre        :string(255)
#  players      :integer
#  developer_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Game < ActiveRecord::Base
  attr_accessible :genre, :name, :players, :website, :developer_id

  belongs_to :developer

  validates :name,  :presence => true,
            :length => { :maximum => 50 }

  validates :genre,  :presence => true,
            :length => { :maximum => 20 }

  validates :website,  :presence => true,
            :length => { :maximum => 50 }

end
