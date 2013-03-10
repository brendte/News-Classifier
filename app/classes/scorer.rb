class Scorer
  include Singleton

  def self.euclidean_length(document_vector)
    Math.sqrt(document_vector.values.reduce(0) {|acc, tf| acc + tf**2})
  end

  def score(document_resource, query_resource)
    # get a db connection, and get references to the dictionary and postings collections
    db = MongoClient.get_connection
    resource_to_match_against = document_resource
  	dictionary = db["#{resource_to_match_against}_dictionary"]
  	postings = db["#{resource_to_match_against}_postings"]

    scores = {}
    n = resource_to_match_against.send(:count)

    Indexer.instance.generate_term_list(query_resource.body).each do |term|
      word_listing = dictionary.find_one({word: term})
      word_id = word_listing.blank? ? nil : word_listing['_id']
      unless word_id.blank?
        postings_list = postings.find_one({word_id: word_id})
        postings_list = postings_list['postings'] unless postings_list.blank?
        postings_list.each do |posting|
          document_id = posting['document_id']
          tf = posting['tf']
          df = word_listing['df']
          binding.pry

          wf = tfidf(tf, df, n)
          if scores.has_key?(document_id)
            scores[document_id] += wf
          else
            scores[document_id] = wf
          end
        end
      end
    end

    scores.map do |document_id, raw_score|
      euclidean_length = resource_to_match_against.send(:where, {id: document_id}).first.euclidean_length
      normalized_score = raw_score/euclidean_length
      [document_id, normalized_score]
    end
  end

  # calc idf
  def idf(n, df)
    Math.log10(n/df).round(5)
  end

  # calc tf-idf
  def tfidf(tf, df, n)
    tf * idf(n, df)
  end

end