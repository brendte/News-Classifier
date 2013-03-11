class Article < ActiveRecord::Base
  include Indexable
  scope :unrouted, where(routed: false)

  has_and_belongs_to_many :users
end
