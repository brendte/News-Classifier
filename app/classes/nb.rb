class NB

  attr_accessor :examples, :vocabulary, :total_words, :p

  def initialize(examples = [{:body => "empty", :value => false}])
    # @examples is an array of hashes of form {:body => text, :value => true|false}
    @examples = examples
    # number of examples
    @number_examples = @examples.size
    # @vocabulary is a hash of distinct words in the examples and the number of occurrences in the corpus
    # it takes the form {:<word> => { :true => <count>, :false => <count>}
    @vocabulary = {}
    # @p holds the a posteriori probabilities.  It takes the form {:<word> => { :true => <probability>, :false => <probability>}
    @p ={}
    # holds the total number of words in all the examples
    @total_words = {:true => 0, :false => 0}
    # total number of documents with value true
    @number_examples_true = 0
    # total number of documents with value false
    @number_examples_false = 0

    slice_n_dice
    calculate_prob
  end

  # cut up and store the examples in various ways as required by the probability computations
  def slice_n_dice
    @examples.each do |example|
      if example[:like] == true
        @number_examples_true = @number_examples_true + 1
      else
        @number_examples_false = @number_examples_false + 1
      end
      value_key = example[:like] ? :true : :false
      example[:body] = remove_formatting_and_punctuation(example[:body])
      t_example = tokenize(example[:body])
      t_example.each do |token|
        @total_words[value_key] = @total_words[value_key] + 1
        if @vocabulary[token]
          @vocabulary[token][value_key] = @vocabulary[token][value_key] + 1
        elsif value_key
          @vocabulary[token] = {:true => 1, :false => 0}
        else
          @vocabulary[token] = {:true => 0, :false => 1}
        end
      end
    end
    @total_words[:total] = @total_words[:true] + @total_words[:false]
  end

  def calculate_prob
    #calculate probability of each value: P(v)

    @p_true = @number_examples_true.to_f / @number_examples.to_f
    @p_false = @number_examples_false.to_f / @number_examples.to_f

    # calculate a posteriori probability of word given value, and store in hash @p {:<word> => {:true => <probability_true>, :false => <probability_false>} })
    @vocabulary.each do |word, count_hash|
      p_true = (count_hash[:true] + 1).to_f / (@total_words[:true] + @vocabulary.size).to_f
      p_false = (count_hash[:false] + 1).to_f / (@total_words[:false] + @vocabulary.size).to_f
      @p[word] = {:true => p_true, :false => p_false}
    end

  end

  def classify(text)
    tokens = tokenize(remove_formatting_and_punctuation(text))
    puts tokens
    p_like = @p_true
    puts "@p_true: #{@p_true}"
    p_dislike = @p_false
    puts "@p_false: #{@p_false}"

    tokens.each do |token|
      if @p[token]
        puts "token: #{token}, true: #{@p[token][:true]}, false: #{@p[token][:false]}"
        p_like = p_like * @p[token][:true]
        p_dislike = p_dislike * @p[token][:false]
        puts "p_like: #{p_like}, p_dislike: #{p_dislike}"
      end
    end
    puts p_like
    puts p_dislike
    {:classification => p_like > p_dislike ? true : false, :p_like => p_like, :p_dislike => p_dislike}

  end

  def remove_formatting_and_punctuation(text)
    text.strip.gsub(/\n/,' ').gsub(/[*.?!'";:,-]/, '')
  end

  def tokenize(text)
    text.downcase.split
  end

end