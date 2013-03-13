# == Schema Information
#
# Table name: articles
#
#  id               :integer          not null, primary key
#  body             :text
#  created_at       :datetime
#  updated_at       :datetime
#  indexed          :boolean
#  euclidean_length :float
#  routed           :boolean
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
