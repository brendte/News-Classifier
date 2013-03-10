class Article < ActiveRecord::Base
  include Indexable

  has_and_belongs_to_many :users
end
