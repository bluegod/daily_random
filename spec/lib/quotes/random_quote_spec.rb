require 'spec_helper'
require 'quotes/random_quote'
require 'quotes/local_quote_factory'

describe "random_quote" do
  let(:factory) {double("LocalQuoteFactory", :size => 2, :get => ['a','b'])}
  let(:quote) {RandomQuote.new(factory)}

  it "calls the factory returning the array of quotes" do
    expect(quote.get(2)).to eq(['a','b'])
  end
end