# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'net/http'
require 'json'
require "redis"


def fortune_key(index)
  "local:#{index}"
end

uri = URI('http://fortunecookieapi.com/v1/fortunes')
response = Net::HTTP.get uri
fortunes = JSON.parse response
@redis = Redis.new
@redis.pipelined do
  fortunes.each_with_index do |fortune, index|
    @redis.set(fortune_key(index), fortune['message'])
  end
end
