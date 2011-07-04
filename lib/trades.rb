require 'rubygems'
require 'socket'
require 'json'
require 'colored'

class Trades
  attr_reader :markets, :last_prices
  
  def initialize(args = [])
    begin
      @socket      = TCPSocket.open("bitcoincharts.com", 27007)
      @markets     = []
      @last_prices = {}

      # Convert the market names to lowercase
      # (CHANGE THIS TO CASE INSENSITIVE REGEX)
      args.each do |x| @markets.push(x.downcase) end
      args.clear # no need to keep them in memory
    rescue
      puts "Error: #{$!}"
    end
  end
  
  def run(&block)
    while data = @socket.gets do
      if data.length > 0 then 
        j = JSON.parse(data.strip.tr("\x00", '')) # Delete all \x00 weirdness
        
        yield j['symbol'], j['timestamp'], j['currency'], j['price'], j['volume']
      end
    end
  end
end