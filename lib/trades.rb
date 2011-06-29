require 'rubygems'
require 'socket'
require 'json'
require 'colored'

class Trades
  def initialize(args = [])
    begin
      puts "Connecting..."
      @socket      = TCPSocket.open("bitcoincharts.com", 27007)
      @exchanges   = []
      @last_prices = {}

      # Convert the exchange names to lowercase
      args.each do |x| @exchanges.push(x.downcase) end
      args.clear

      #     thUSD          | 2011-06-27 23:00:55 | USD      | 17.05  | 0.5    |
      puts "Exchange       | Date and time       | Currency | Price  | Volume |"
      
      self.loop
    rescue
      puts "Error: #{$!}"
    end
  end
  
  def loop
    while data = @socket.gets do
      if data.length > 0
        j = JSON.parse(data.strip.tr("\x00", '')) # Delete all \x00 weirdness
    
        if @exchanges.empty? or @exchanges.include?(j['symbol'].downcase) then
          line  = j['symbol'].ljust(15) + "| "
          line += Time.at(j['timestamp']).strftime("%Y-%m-%d %H:%M:%S").\
          ljust(20)
          line += "| " + j['currency'].ljust(9) + "| "
          
          # Coloring: Compare the current price and the last price
          current_price = j['price'].round(2)
          last_price    = @last_prices[j['symbol']].to_f # Its 0 on startup
          
          if current_price > last_price then
            line += current_price.to_s.ljust(7).green
          elsif current_price < last_price then
            line += current_price.to_s.ljust(7).red
          else
            line += current_price.to_s.ljust(7)
          end
          
          @last_prices[j['symbol']] = current_price
          
          
          line += "| " + j['volume'].round(2).to_s.ljust(7) + "|"
    
          puts line
        end
      end
    end
  end
end