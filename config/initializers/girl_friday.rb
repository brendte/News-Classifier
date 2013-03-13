ROUTE_NEW_QUERY = GirlFriday::WorkQueue.new(:route_new_query) do |msg|
  query = Query.where(id: msg[:query_id]).first unless msg.blank? || msg[:query_id].blank?
  ArticleRouter.instance.route_on_new_query(query) unless query.blank?
end