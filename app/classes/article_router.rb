class ArticleRouter
  #TODO: when new articles come in, this will go out to mongo queries collection, and retrieve all queries that contain at least one the words in the article
  # it will then score the article against the full query, and if it meets or exceeds a threshold value, it will assign the article to the user who the query
  # belongs to take query_id from query doc in mongo, lookup Query with that id in AR, traverse to user via Query#user and assign the article id to User#articles
end