unless Rails.env.to_sym == :development
  scheduler = Rufus::Scheduler.start_new

  scheduler.every('30m', first_in: '5m') do
    CRAWL_INDEX_ROUTE << {}
  end
end