unless Rails.env.to_sym == :development
  scheduler = Rufus::Scheduler.start_new

  scheduler.every('30m', first_in: '5m') do
    #synchronized on Index::index_mutex to ensure multiple jobs won't run concurrently
    if Indexer.index_mutex.try_lock
      Rails.logger.info "Crawler#crawl task started at #{Time.now.utc}"
      Crawler.instance.crawl
      Rails.logger.info "Crawler#crawl task finished at #{Time.now.utc}"
      Rails.logger.info "Article::index_new task started at #{Time.now.utc}"
      Article.index_new
      Rails.logger.info "Article::index_new task finished at #{Time.now.utc}"
      Rails.logger.info "Query::index_new task started at #{Time.now.utc}"
      Query.index_new
      Rails.logger.info "Query::index_new task finished at #{Time.now.utc}"
      Rails.logger.info "ArticleRouter#route_new task started at #{Time.now.utc}"
      ArticleRouter.instance.route_new
      Rails.logger.info "ArticleRouter#route_new task finished at #{Time.now.utc}"
      Indexer.index_mutex.unlock
    else
      Rails.logger.info "Couldn't obtain lock on Index::index_mutex. Will try again in an hour (around #{Time.now.utc + 3600}. Bye!"
    end
  end
end