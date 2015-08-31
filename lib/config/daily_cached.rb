require 'qless'
require 'redis'

#module to hold a cached version of redis and qless. Encapsulation here also makes it easier to use the config only in one place.
module DailyCached
  class << self
    def redis
      @redis ||= Redis.new(:url => (ENV["REDIS_URL"] || 'redis://127.0.0.1:6379'))
    end

    def qless
      @qless ||= Qless::Client.new(:url => (ENV["REDIS_URL"] || 'redis://127.0.0.1:6379'))
    end
  end
end