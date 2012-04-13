# == Schema Information
#
# Table name: developers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  website    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  image      :string(255)
#

require 'spec_helper'

describe Developer do
  let(:developer) { FactoryGirl.create(:developer) }

  subject { developer }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:website) }
  it { should respond_to(:games) }

  describe "when name is not present" do
    before { developer.name = " " }
    it { should_not be_valid }
  end

  describe "when website is not present" do
    before { developer.website = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { developer.name = "a"*51 }
    it { should_not be_valid }
  end

  describe "when website format is invalid" do
    it "should not be valid" do
      @developer = FactoryGirl.create(:developer)
      addresses = %w[test://1234 foobar www,foobar.com mailto:name@example.com]
      addresses.each do |invalid_address|
        @developer.website = invalid_address
        @developer.should_not be_valid
      end
    end
  end

  describe "when website format is valid" do
    it "should be valid" do
      @developer = FactoryGirl.create(:developer)
      addresses = %w[www.foobar.com http://www.foobar.com/]
      addresses.each do |valid_address|
        @developer.website = valid_address
        @developer.should be_valid
      end
    end
  end

end
