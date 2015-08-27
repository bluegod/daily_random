require 'quotes/local_quote_factory'

class RandomQuote
  def initialize(factory = LocalQuoteFactory.new)
    @size = factory.size
    @factory = factory
  end

  def get(max)
    @factory.get(random_array(max))
  end

  private
  #array of random numbers between 0 and @size, taking only max
  def random_array(max)
    (0..@size).to_a.shuffle.take(max)
  end
end