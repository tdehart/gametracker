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

require 'spec_helper'

describe Game do
  let(:game) { FactoryGirl.create(:game) }

  subject { game }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:website) }
  it { should respond_to(:players) }
  it { should respond_to(:genre) }
  it { should respond_to(:developer) }


  describe "when name is not present" do
    before { game.name = " " }
    it { should_not be_valid }
  end

  describe "when website is not present" do
    before { game.website = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { game.name = "a"*51 }
    it { should_not be_valid }
  end

  describe "when genre is too long" do
    before { game.genre = "a"*21 }
    it { should_not be_valid }
  end
end
