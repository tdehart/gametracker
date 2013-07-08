# == Schema Information
#
# Table name: web_resources
#
#  id                :integer          not null, primary key
#  url               :string(255)
#  resourceable_id   :integer
#  resourceable_type :string(255)
#  resource_type     :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class WebResource < ActiveRecord::Base
  belongs_to :resourceable, :polymorphic => true
end
