require 'bundler/setup'
require 'colored'
require 'minitest/spec'
require 'minitest/autorun'
require 'trades/trade'

describe Trade do
  before do
    json = '{"volume": 1.26934, "timestamp": 1321111130, 
    "price": 2.998, "symbol": "btceUSD", "id": 15366282}'
    @trade = Trade.new(json)
  end
  
  it "should have attributes of the appropriate type" do
    @trade.id.must_be_kind_of Integer
    @trade.market.must_be_kind_of String
    @trade.timestamp.must_be_kind_of String
    @trade.currency.must_be_kind_of String
    @trade.currency.length.must_be :==, 3
    @trade.price.must_be_kind_of Float
    @trade.volume.must_be_kind_of Float
  end
  
  it "should have timestamps in the correct formats" do
    @trade.timestamp(true).must_be :==, "2011-11-12 16:18:50"
    @trade.timestamp(false).must_be :==, "16:18:50"
  end
  
  it "should have an option to specify decimals for the price attribute" do
    @trade.price(2).must_be :==, 3.00
  end
  
  it "should output a nicely formatted string" do
    regex = /(.{15}) \| ((\d{4}-\d{2}-\d{2} )?\d{2}:\d{2}:\d{2}) \| ([a-zA-z ]{9}) \| ([0-9 \.]{9}) \| ([0-9 \.]+)/i
    @trade.to_s.must_match regex
  end
end