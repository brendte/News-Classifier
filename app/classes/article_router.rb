class ArticleRouter
  include Singleton

  DEFAULT_THRESHOLD = 0.5

  def route_article(article, queries)
    queries = [queries] unless queries.is_a?(Array)
    queries.each do |query|
      score = article.score_against(query)[0][1]
      threshold = query.threshold ? query.threshold : ArticleRouter::DEFAULT_THRESHOLD
      if score >= threshold
        query.user.articles << article unless query.user.articles.exists?(article)
      end
    end
  end

  def route_new
    queries = Query.all
    Article.unrouted.each do |article|
      self.route_article(article, queries)
      article.routed = true
      article.save
    end
  end

  def route_on_new_query(query)
    Article.all.each do |article|
      self.route_article(article, query)
    end
  end
end