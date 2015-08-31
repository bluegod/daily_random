require 'qless'
require 'quotes/random_quote'
require 'jobs/daily_sender'
require 'config/daily_cached'

class DailyQuoteManager
  #Added daily sender jobs to the queue in batches of subscribers
  def self.perform(job)
    queue = client.queues[ENV['default_queue']]
    Subscriber.find_in_batches(batch_size: ENV['batch_size'].to_i).with_index do |group, batch|
      Rails.logger.debug "Processing group ##{batch}"
      quotes = random_quote.get(group.size)
      group.each {|sub| queue.put(sender_class, {email: sub.email, content: quotes.pop, token: sub.token}, jid: sub.email)}
    end
  end

  def self.sender_class
    DailySender
  end

  def self.random_quote
    @_random_quote ||= RandomQuote.new
  end

  def self.client
    DailyCached.qless
  end
end

