# == Schema Information
#
# Table name: queries
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  body             :text
#  indexed          :boolean
#  euclidean_length :float
#  threshold        :float
#

require 'test_helper'

class QueryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
