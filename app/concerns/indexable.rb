# Include in any model that should be able to be indexed
# For this to work, any model in which this module is included must have 2 fields:
# indexed (type :boolean)
# euclidean_length (type: float)

module Indexable
  extend ActiveSupport::Concern

  included do
    scope :unindexed, where(indexed: false)

    def generate_term_list
      Indexer.instance.generate_term_list(self.body)
    end

    def score_against(query_instance)
      s = Scorer.instance
      s.score_one(self, query_instance)
    end
  end

  module ClassMethods
    def index_new
      i = Indexer.instance
      i.index(unindexed, self)
    end

    def score_all_against(query_instance)
      s = Scorer.instance
      s.score_all(self, query_instance)
    end
  end
end