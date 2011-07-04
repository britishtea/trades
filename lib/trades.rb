require 'rubygems'
require 'socket'
require 'json'
require 'colored'

class Trades
  def initialize(args = [])
    begin
      puts "Connecting to bitcoincharts.com..."
      @socket      = TCPSocket.open("bitcoincharts.com", 27007)
      @markets     = []
      @last_prices = {}

      # Convert the market names to lowercase
      # (CHANGE THIS TO CASE INSENSITIVE REGEX)
      args.each do |x| @markets.push(x.downcase) end
      args.clear # no need to keep them in memory

      #     thUSD          | 2011-06-27 23:00:55 | USD      | 17.05    | 0.5       |
      puts "Exchange       | Date and time       | Currency | Price    | Volume    |"
      
      self.loop
    rescue
      puts "Error: #{$!}"
    end
  end
  
  def loop
    while data = @socket.gets do
      if data.length > 0 then 
        j = JSON.parse(data.strip.tr("\x00", '')) # Delete all \x00 weirdness
    
        if @markets.empty? or @markets.include?(j['symbol'].downcase) then
          line  = j['symbol'].ljust(15) + "| " # market
          line += Time.at(j['timestamp']).strftime("%Y-%m-%d %H:%M:%S") + " | "
          line += j['currency'].ljust(9) + "| " # currency
          
          # Price: display higher price in green / lower price in red
          current_price = j['price'].round(2)
          last_price    = @last_prices[j['symbol']].to_f # Its nil on startup
          @last_prices[j['symbol']] = current_price # store for next comparison
          
          price = current_price.to_s.ljust(9)
          price = price.green if current_price > last_price unless last_price.zero?
          price = price.red if current_price < last_price
          
          line += price + "| " + j['volume'].round(2).to_s.ljust(9) + " |"
    
          puts line
        end
      end
    end
  end
end