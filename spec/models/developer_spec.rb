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

  describe "when website is too long" do
    before { developer.website = "a"*51 }
    it { should_not be_valid }
  end
end
