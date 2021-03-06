# == Schema Information
#
# Table name: tournaments
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  link                :string(255)
#  start_date          :date
#  prize_pool_cents    :integer
#  num_competitors     :integer
#  game_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text(255)
#  image               :string(255)
#  end_date            :date
#  currency            :string(255)
#  chronic_start_input :string(255)
#  chronic_end_input   :string(255)
#

require 'spec_helper'

describe Tournament do
  let(:tournament) { FactoryGirl.create(:tournament) }

  subject { tournament }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:link) }
  it { should respond_to(:region) }
  it { should respond_to(:date) }
  it { should respond_to(:prize_pool) }
  it { should respond_to(:num_competitors) }
  it { should respond_to(:game) }
  it { should respond_to(:events) }
  it { should respond_to(:streams) }


  describe "when name is not present" do
    before { tournament.name = " " }
    it { should_not be_valid }
  end

  describe "when link is not present" do
    before { tournament.link = " " }
    it { should_not be_valid }
  end

  describe "when region is not present" do
    before { tournament.region = " " }
    it { should_not be_valid }
  end

  describe "when tournament date is not present" do
    before { tournament.date = nil }
    it { should_not be_valid }
  end

  describe "when prize pool is not present" do
    before { tournament.prize_pool = nil }
    it { should_not be_valid }
  end

  describe "when game is not present" do
    before { tournament.game = nil }
    it { should_not be_valid }
  end

  describe "when number of competitors is not present" do
    before { tournament.num_competitors = nil }
    it { should be_valid }
  end

  describe "when link format is invalid" do
    it "should not be valid" do
      @tournament = FactoryGirl.create(:tournament)
      addresses = %w[test://1234 foobar www,foobar.com mailto:name@example.com]
      addresses.each do |invalid_address|
        @tournament.link = invalid_address
        @tournament.should_not be_valid
      end
    end
  end

  describe "when link format is valid" do
    it "should be valid" do
      @tournament = FactoryGirl.create(:tournament)
      addresses = %w[www.foobar.com http://www.foobar.com/]
      addresses.each do |valid_address|
        @tournament.link = valid_address
        @tournament.should be_valid
      end
    end
  end
end
