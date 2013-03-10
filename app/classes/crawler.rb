class Crawler
  include Singleton

  #TODO: finish documenting this code
  def update_all_feeds
    Feed.all.each do |feed_entry|
      feed = Feedzirra::Feed.fetch_and_parse(feed_entry.feed_url)
      if !feed.blank? && !feed.entries.blank?
        feed.entries.each do |entry|
          guid = Base64.urlsafe_encode64(OpenSSL::Digest::MD5.digest(entry.id))
          unless FeedEntry.exists?(guid: guid)
            FeedEntry.create(title: entry.title, summary: entry.summary, url: entry.url, published_at: entry.published, guid: guid, fetched: false)
          end
        end
      end
    end
  end

  def fetch_and_store_articles
    hydra = Typhoeus::Hydra.new(max_concurrency: 20)
    FeedEntry.where(fetched: false).limit(10).each do |feed_entry|
      request = Typhoeus::Request.new("http://access.alchemyapi.com/calls/url/URLGetText?apikey=2dca9a7577657ed330d2a99e2744a167f043b3c6&outputMode=json&url=#{feed_entry.url}")
      #binding.pry
      request.on_complete &store_article(feed_entry)
      hydra.queue(request)
    end
    hydra.run
  end

  private

  def store_article(feed_entry)
    Proc.new do |body_response|
      begin
        if body_response.code == 200
          body = body_response.body['text'] ? JSON.parse(body_response.body)['text'] : ''
          if body.blank?
            raise "Alchemy didn't show you any love"
          else
            if Article.new(title: feed_entry.title, body: body, url: feed_entry.url, publish_date: feed_entry.published_at, like: false, indexed: false).save
              feed_entry.fetched = true
              feed_entry.save
            else
              raise "Couldn't save the article."
            end
            #bin_nb = UserNb.find_by_user(current_user).nb_obj
            #nb = NB.new
            #nb = Marshal.load(bin_nb)
            #nb.classify(body)
          end
        else
          raise "Alchemy didn't show you any love"
        end
      rescue Exception => e
         Rails.logger.error "Something went wrong: #{e}"
      end
    end
  end

end