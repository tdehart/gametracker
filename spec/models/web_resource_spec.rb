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

require 'spec_helper'

describe WebResource do
  pending "add some examples to (or delete) #{__FILE__}"
end
