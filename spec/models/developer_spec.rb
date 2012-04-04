require 'spec_helper'

describe Developer do
  let(:developer) { FactoryGirl.create(:developer) }

  subject { developer }

  it { should respond_to(:name) }
  it { should respond_to(:website) }
  it { should be_valid }

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
