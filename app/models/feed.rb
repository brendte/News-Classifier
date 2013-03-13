# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  feed_url   :string(255)
#  etag       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Feed < ActiveRecord::Base
end
