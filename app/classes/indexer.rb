class Indexer
  include Singleton

  STOP_WORDS = 'a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,neither,no,nor,not,of,off,often,on,only,or,other,our,own,rather,said,say,says,she,should,since,so,some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,where,which,while,who,whom,why,will,with,would,yet,you,your,use,used'.split(',')

  def index(documents, calling_resource)
    update_dictionary_and_postings(documents, calling_resource)
  end

  def generate_term_list(document)
    document_prep(document)
  end

  private

  def document_prep(document)
    # remove punctuation, convert all upper case letters to lower case letters, tokenize (split) into words, and remove stop words
    unstemmed_words =  document.gsub(/[[:punct:]]/, '').downcase.split.select { |word| !STOP_WORDS.include?(word) }
    # use Porter's stemming algorithm to stem the words, and store them as symbols
    unstemmed_words.map { |word| word.stem.to_sym }
  end

  def update_dictionary_and_postings(documents, calling_resource)
  	# this hash will hold the processed documents during processing. this will be used to store the index to disk
    # once all documents are processed. The reason for doing this (as opposed to writing each document's index data to disk after each document is processed)
    # is to prevent the db connection from being open for potentially long periods of time while documents are being processed.
    processed_documents = {}

  	# for each document in the passed-in documents collection, do the following:
    documents.each do |document|
      # initialize an empty hash to hold all the terms and term frequencies in this document: {:hello=>4,:there=>1}
  		words_in_this_document = {}

      # prep the words in the document
  		document_prep(document.body).each do |word|
        # count the number of times a word appears in this document by iterating over the words array
        # and either adding the word to the hash and setting the word count to 1, or incrementing the word count
        # for an existing word by 1. for the document "hello there hello hello hello"
        # the words_in_this_document hash has the final form {:hello=>4,:there=>1}
        words_in_this_document[word] = words_in_this_document.has_key?(word) ? words_in_this_document[word] + 1 : 1
      end

      # add all the word=>word_count entries in this document's hash to the processed_documents hash for use below
      processed_documents[document.id] = words_in_this_document
    end

    # get a db connection, and get references to the dictionary and postings collections
    db = MongoClient.get_connection
  	dictionary = db["#{calling_resource}_dictionary"]
  	postings = db["#{calling_resource}_postings"]

    # loop over all the processed documents and save the stats to the dictionary and postings lists
    processed_documents.each do |document_id, words_in_this_document|
      # for each word=>word_count pair in the words_in_this_document hash, store the stats to the db
      words_in_this_document.each do |word, tf|
        # try to fetch the dictionary entry for this word from the db
        dictionary_entry = dictionary.find_one(word: word)
        if dictionary_entry # a dictionary entry exists for this word, so increment it's df by 1 and store back to the dictionary
          df = dictionary_entry['df'] + 1
          dictionary.update({_id: dictionary_entry['_id']}, {'$set' => {df: df}})
          dictionary_id = dictionary_entry['_id']
        else # no dictionary entry exists for this word, so create a new entry for the word with df = 1 (since this is the 1st doc the word has appeared in)
          df = 1
          dictionary_id = dictionary.insert({word: word, df: df})
        end

        postings_list = postings.find_one({word_id: dictionary_id})
        if postings_list # there's a postings list for this word already, so just add this posting to it to record the tf for this term for this document
          postings.update({_id: postings_list['_id']}, {'$push' => {postings: {document_id: document_id, tf: tf}}})
        else # no postings list for this word, so create a new list using the word's id, and adding as first posting record the tf for this term for this document
          postings.insert({word_id: dictionary_id, postings: [{document_id: document_id, tf: tf}]})
        end
      end

      # we're done indexing this document, so mark it as indexed in the db
      document_to_update = calling_resource.send(:where, {id: document_id}).first
      document_to_update.euclidean_length = Scorer.euclidean_length(words_in_this_document)
      document_to_update.indexed = true
      document_to_update.save
    end
  end
end