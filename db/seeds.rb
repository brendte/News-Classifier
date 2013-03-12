# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

feeds = %w{
  http://rss.cnn.com/rss/cnn_topstories.rss
  http://rss.cnn.com/rss/cnn_world.rss
  http://rss.cnn.com/rss/cnn_us.rss
  http://rss.cnn.com/rss/money_latest.rss
  http://rss.cnn.com/rss/cnn_allpolitics.rss
  http://rss.cnn.com/rss/cnn_crime.rss
  http://rss.cnn.com/rss/cnn_tech.rss
  http://rss.cnn.com/rss/cnn_health.rss
  http://rss.cnn.com/rss/cnn_showbiz.rss
  http://rss.cnn.com/rss/cnn_travel.rss
  http://rss.cnn.com/rss/cnn_living.rss
  http://rss.cnn.com/rss/cnn_studentnews.rss
  http://rss.cnn.com/rss/cnn_mostpopular.rss
  http://rss.cnn.com/rss/cnn_latest.rss
  http://rss.ireport.com/feeds/oncnn.rss
  http://rss.cnn.com/rss/cnn_behindthescenes.rss
  http://www.nytimes.com/services/xml/rss/nyt/pop_top.xml
  http://www.nytimes.com/services/xml/rss/nyt/Multimedia.xml
  http://www.nytimes.com/services/xml/rss/nyt/TimesSelect.xml
  http://www.nytimes.com/services/xml/rss/nyt/ArtandDesign.xml
  http://www.nytimes.com/services/xml/rss/nyt/Arts.xml
  http://www.nytimes.com/services/xml/rss/nyt/Music.xml
  http://www.nytimes.com/services/xml/rss/nyt/Television.xml
  http://www.nytimes.com/services/xml/rss/nyt/Automobiles.xml
  http://www.nytimes.com/services/xml/rss/nyt/Books.xml
  http://www.nytimes.com/services/xml/rss/nyt/SundayBookReview.xml
  http://www.nytimes.com/services/xml/rss/nyt/Business.xml
  http://www.nytimes.com/services/xml/rss/nyt/MediaandAdvertising.xml
  http://www.nytimes.com/services/xml/rss/nyt/WorldBusiness.xml
  http://www.nytimes.com/services/xml/rss/nyt/YourMoney.xml
  http://www.nytimes.com/services/xml/rss/nyt/DiningandWine.xml
  http://www.nytimes.com/services/xml/rss/nyt/Education.xml
  http://www.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml
  http://www.nytimes.com/services/xml/rss/nyt/SundayStyles.xml
  http://www.nytimes.com/services/xml/rss/nyt/ThursdayStyles.xml
  http://www.nytimes.com/services/xml/rss/nyt/Weddings.xml
  http://www.nytimes.com/services/xml/rss/nyt/Health.xml
  http://www.nytimes.com/services/xml/rss/nyt/HealthCarePolicy.xml
  http://www.nytimes.com/services/xml/rss/nyt/Psychology.xml
  http://www.nytimes.com/services/xml/rss/nyt/Nutrition.xml
  http://www.nytimes.com/services/xml/rss/nyt/HomeandGarden.xml
  http://www.nytimes.com/services/xml/rss/nyt/MiddleEast.xml
  http://www.nytimes.com/services/xml/rss/nyt/International.xml
  http://www.nytimes.com/services/xml/rss/nyt/Europe.xml
  http://www.nytimes.com/services/xml/rss/nyt/AsiaPacific.xml
  http://www.nytimes.com/services/xml/rss/nyt/Americas.xml
  http://www.nytimes.com/services/xml/rss/nyt/Africa.xml
  http://www.nytimes.com/services/xml/rss/nyt/JobMarket.xml
  http://www.nytimes.com/services/xml/rss/nyt/Magazine.xml
  http://www.nytimes.com/services/xml/rss/nyt/MovieNews.xml
  http://www.nytimes.com/services/xml/rss/nyt/Movies.xml
  http://www.nytimes.com/services/xml/rss/nyt/RedCarpet.xml
  http://www.nytimes.com/services/xml/rss/nyt/National.xml
  http://www.nytimes.com/services/xml/rss/nyt/MetroCampaigns.xml
  http://www.nytimes.com/services/xml/rss/nyt/NYRegion.xml
  http://www.nytimes.com/services/xml/rss/nyt/TheCity.xml
  http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml
  http://www.nytimes.com/services/xml/rss/nyt/Obituaries.xml
  http://www.nytimes.com/services/xml/rss/nyt/Opinion.xml
  http://www.nytimes.com/services/xml/rss/nyt/RealEstate.xml
  http://www.nytimes.com/services/xml/rss/nyt/Environment.xml
  http://www.nytimes.com/services/xml/rss/nyt/Science.xml
  http://www.nytimes.com/services/xml/rss/nyt/Space.xml
  http://www.nytimes.com/services/xml/rss/nyt/Baseball.xml
  http://www.nytimes.com/services/xml/rss/nyt/CollegeBasketball.xml
  http://www.nytimes.com/services/xml/rss/nyt/CollegeFootball.xml
  http://www.nytimes.com/services/xml/rss/nyt/Golf.xml
  http://www.nytimes.com/services/xml/rss/nyt/Hockey.xml
  http://www.nytimes.com/services/xml/rss/nyt/OtherSports.xml
  http://www.nytimes.com/services/xml/rss/nyt/ProBasketball.xml
  http://www.nytimes.com/services/xml/rss/nyt/ProFootball.xml
  http://www.nytimes.com/services/xml/rss/nyt/Soccer.xml
  http://www.nytimes.com/services/xml/rss/nyt/Sports.xml
  http://www.nytimes.com/services/xml/rss/nyt/Circuits.xml
  http://www.nytimes.com/services/xml/rss/nyt/Technology.xml
  http://www.nytimes.com/services/xml/rss/nyt/PoguesPosts.xml
  http://www.nytimes.com/services/xml/rss/nyt/Theater.xml
  http://www.nytimes.com/services/xml/rss/nyt/Escapes.xml
  http://www.nytimes.com/services/xml/rss/nyt/Travel.xml
  http://www.nytimes.com/services/xml/rss/nyt/Washington.xml
  http://www.nytimes.com/services/xml/rss/nyt/WeekinReview.xml
  http://www.businessweek.com/feeds/most-popular.rss
}

feeds.each {|url| Feed.create(feed_url: url, etag: '')}

User.create(email: 'brendte@gmail.com', password: 'please', password_confirmation: 'please')
User.create(email: 'brendteneickstaedt@gmail.com', password: 'please', password_confirmation: 'please')