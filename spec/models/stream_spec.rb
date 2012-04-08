# == Schema Information
#
# Table name: streams
#
#  id          :integer         not null, primary key
#  link        :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Stream do
  let(:stream) { FactoryGirl.create(:stream) }

  subject { stream }

  it { should be_valid }
  it { should respond_to(:link) }
  it { should respond_to(:description) }
  it { should respond_to(:streamers) }
  it { should respond_to(:games) }
  it { should respond_to(:events) }
  it { should respond_to(:tournaments) }
end
