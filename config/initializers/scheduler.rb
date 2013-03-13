unless Rails.env.to_sym == :development
  scheduler = Rufus::Scheduler.start_new

  scheduler.every('30m') do
    Rails.logger.info "Crawler#crawl task started at #{Time.now}"
    Crawler.instance.crawl
    Rails.logger.info "Crawler#crawl task finished at #{Time.now}"
    Rails.logger.info "Article::index_new task started at #{Time.now}"
    Article.index_new
    Rails.logger.info "Article::index_new task finished at #{Time.now}"
    Rails.logger.info "Query::index_new task started at #{Time.now}"
    Query.index_new
    Rails.logger.info "Query::index_new task finished at #{Time.now}"
    Rails.logger.info "ArticleRouter#route_new task started at #{Time.now}"
    ArticleRouter.instance.route_new
    Rails.logger.info "ArticleRouter#route_new task finished at #{Time.now}"
  end
end