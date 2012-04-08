# == Schema Information
#
# Table name: games
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  website      :string(255)
#  genre        :string(255)
#  num_players  :integer
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
  it { should respond_to(:num_players) }
  it { should respond_to(:genre) }
  it { should respond_to(:developer) }
  it { should respond_to(:streams) }
  it { should respond_to(:tournaments) }


  describe "when name is not present" do
    before { game.name = " " }
    it { should_not be_valid }
  end

  describe "when website is not present" do
    before { game.website = " " }
    it { should_not be_valid }
  end

  describe "when genre is not present" do
    before { game.genre = " " }
    it { should_not be_valid }
  end

  describe "when developer is not present" do
    before { game.developer = nil }
    it { should_not be_valid }
  end

  describe "when players is not present" do
    before { game.num_players = nil }
    it { should be_valid }
  end

  describe "when players is less than 0" do
    before { game.num_players = -1 }
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

  describe "when website format is invalid" do
    it "should not be valid" do
      @game = FactoryGirl.create(:game)
      addresses = %w[test://1234 foobar www,foobar.com mailto:name@example.com]
      addresses.each do |invalid_address|
        @game.website = invalid_address
        @game.should_not be_valid
      end
    end
  end

  describe "when website format is valid" do
    it "should be valid" do
      @game = FactoryGirl.create(:game)
      addresses = %w[www.foobar.com http://www.foobar.com/]
      addresses.each do |valid_address|
        @game.website = valid_address
        @game.should be_valid
      end
    end
  end
end
