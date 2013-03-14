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

  after_save :route_me

  def self.build_full(params, user)
    threshold = params[:query][:threshold].to_f
    params[:query][:threshold] = '1.0' if threshold > 1.0
    params[:query][:threshold] = '0.1' if threshold < 0.1
    params[:query].merge!({indexed: false, euclidean_length: 0.0})
    query = self.new(params[:query])
    query.user = user
    query
  end

  private

  def route_me
    ROUTE_NEW_QUERY << {query_id: self.id}
  end
end
