require "redis"
require 'config/daily_cached'

#storage of quotes in redis
class LocalQuoteFactory
  def initialize
    @redis = DailyCached.redis
  end

  def get(random_array)
    @redis.pipelined do
      random_array.each do |num|
        @redis.get("local:#{num}")
      end
    end
  end

  def size
    @_size ||= @redis.keys("local:*").count
  end
end