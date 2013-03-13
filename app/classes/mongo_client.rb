require 'mongo'

class MongoClient

  class << self
    attr_reader :db_connection
  end

  def self.get_connection
    return @db_connection if @db_connection
    mongo_url = URI.parse(ENV['MONGOHQ_URL'])
    @mongo_client = Mongo::MongoClient.new(mongo_url.host, mongo_url.port)
    @db_connection = @mongo_client.db(mongo_url.path.delete('/'))
    @db_connection.authenticate(mongo_url.user, mongo_url.password)
    @db_connection
  end

end