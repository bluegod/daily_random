require 'rails_helper'
require 'jobs/daily_quote_manager'

describe DailyQuoteManager do
  let(:client) { Qless::Client.new }
  let(:job)    { Qless::Job.build(client, DailyQuoteManager, :data => { "some" => "data" }) }
  let!(:subscriber) {create(:subscriber)}
  let!(:subscriber2) {create(:subscriber)}
  let(:factory) {double("LocalQuoteFactory", :size => 2, :get => ['a','b'])}
  let(:quote) {RandomQuote.new(factory)}
  let(:sender) {double('sender', :random_mail => [], :name => 'DailySender')}

  before(:each) do
    allow(DailyQuoteManager).to receive(:random_quote).and_return(quote)
    allow(DailyQuoteManager).to receive(:sender_class).and_return(sender)
    allow(DailySender).to receive(:perform).with(any_args).and_return('done')
  end

  it 'executes the two jobs' do
    DailyQuoteManager.perform(job)
    expect(job_result).to match_array(['done', 'done'])
  end
end


def job_result
  queue = client.queues[ENV['default_queue']]
  result = []
  job = queue.pop
  result << job.perform
  job = queue.pop
  result << job.perform
  result
end