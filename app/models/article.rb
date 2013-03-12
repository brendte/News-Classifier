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

class Article < ActiveRecord::Base
  include Indexable
  scope :unrouted, where(routed: false)

  has_and_belongs_to_many :users
  has_one :feed_entry
end
