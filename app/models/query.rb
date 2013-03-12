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

class Query < ActiveRecord::Base
  include Indexable

  belongs_to :user

  after_create :route_me

  #TODO: user can create free-text queries. these are run through Indexer#process_new_query and then saved to the queries collection in mongo
  # queries collection {query_id: <Query#id>, terms: [:this, :that, :thing, ...]}
  # once the query is stored in mongo, the doc id from mongo is stored in Query#query_term_list_id as a string (BSON::ObjectId#to_s)
  # to fetch queries from mongo via a Query, do BSON::ObjectId.new(Query#query_term_list_id)

  private

  def route_me
    ArticleRouter.instance.route_on_new_query(self)
  end
end
