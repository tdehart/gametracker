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

require 'spec_helper'

describe Streamer do
  let(:streamer) { FactoryGirl.create(:streamer) }

  subject { streamer }

  it { should be_valid }
  it { should respond_to(:online_name) }
  it { should respond_to(:real_name) }
  it { should respond_to(:website) }
  it { should respond_to(:biography) }
  it { should respond_to(:birthday) }
  it { should respond_to(:nationality) }
  it { should respond_to(:streams) }

  describe "when online name is not present" do
    before { streamer.online_name = " " }
    it { should_not be_valid }
  end

  describe "when real name is not present" do
    before { streamer.real_name = " " }
    it { should be_valid }
  end

  describe "when website is not present" do
    before { streamer.website = " " }
    it { should be_valid }
  end

  describe "when biography is not present" do
    before { streamer.biography = " " }
    it { should be_valid }
  end

  describe "when birthday is not present" do
    before { streamer.birthday = nil }
    it { should be_valid }
  end

  describe "when nationality is not present" do
    before { streamer.nationality = " " }
    it { should be_valid }
  end

  describe "when website format is invalid" do
    it "should not be valid" do
      @streamer = FactoryGirl.create(:streamer)
      addresses = %w[test://1234 foobar www,foobar.com mailto:name@example.com]
      addresses.each do |invalid_address|
        @streamer.website = invalid_address
        @streamer.should_not be_valid
      end
    end
  end

  describe "when website format is valid" do
    it "should be valid" do
      @streamer = FactoryGirl.create(:streamer)
      addresses = %w[www.foobar.com http://www.foobar.com/]
      addresses.each do |valid_address|
        @streamer.website = valid_address
        @streamer.should be_valid
      end
    end
  end
end
