# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "typhoeus"

hydra = Typhoeus::Hydra.new

category_request = Typhoeus::Request.new(
    "http://api.feedzilla.com/v1/categories.json",
    :method => :get,
    :headers => {:Accept => "application/json"},
    :params => {:order => "popular"}
)
@category_article_metadata_requests = []
@category_article_metadata_response = []

hydra.queue(category_request)
hydra.run

category_response = category_request.response
@categories = ActiveSupport::JSON.decode(category_response.body)

i = 0
@categories.each do |c|

  puts c
  Category.create({ :feedzilla_id => c['category_id'], :name => c['display_category_name'], :feedzilla_url_name => c['url_category_name'] })
  puts "Created category #{c['display_category_name']}"

  #create request body
  @category_article_metadata_requests[i] = Typhoeus::Request.new(
    "http://api.feedzilla.com/v1/categories/#{c['category_id']}/articles.json",
    :method => :get,
    :headers => {:Accept => "application/json"},
    :params => {:count => "100"}
  )

  #create callback for request
  @category_article_metadata_requests[i].on_complete do |response|
    ActiveSupport::JSON.decode response.body
  end

  #queue the request
  hydra.queue @category_article_metadata_requests[i]

  i = i + 1
end

#make calls to get category article metadata
hydra.run

@category_article_metadata_requests.each do |category|
  articles = category.handled_response['articles']
  articles.each do |article|
    Article.create({ :title => article['title'], :body => article['summary'], :url => article['url'], :publish_date => article['publish_date'] })
    puts "==> Created article #{article['title']}"
  end
end


