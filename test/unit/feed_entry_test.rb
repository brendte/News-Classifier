# == Schema Information
#
# Table name: feed_entries
#
#  id           :integer          not null, primary key
#  summary      :text
#  url          :string(255)
#  published_at :datetime
#  guid         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  title        :string(255)
#  fetched      :boolean
#  article_id   :integer
#

require 'test_helper'

class FeedEntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
