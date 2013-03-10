class ScoreAndRanker

  #TODO: implement the scoring and ranking of docs, called by article_router when new articles come in
  #calculate cosine similarity of query vector and tf-idf weighted document vector

  # calc idf
  def idf(df)
    n = Article.count
    Math.log10(n/df).round(5)
  end

  # calc tf-idf
  def tfidf(tf, df)
    tf * idf(df)
  end

end