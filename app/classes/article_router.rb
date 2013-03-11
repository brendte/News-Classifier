class ArticleRouter
  include Singleton

  DEFAULT_THRESHOLD = 0.5

  def route_article(article)
    Query.all.each do |query|
      score = article.score_against(query)[0][1]
      threshold = query.threshold ? query.threshold : ArticleRouter::DEFAULT_THRESHOLD
      if score >= threshold
        query.user.articles << article unless query.user.articles.exists?(article)
      end
    end

    article.routed = true
    article.save
  end

  def route_new
    Article.unrouted.each do |article|
      self.route_article(article)
    end
  end
end