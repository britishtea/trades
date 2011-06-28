require 'rubygems'
require 'socket'
require 'json'

class Trades
  def initialize(args = [])
    @socket    = TCPSocket.open("bitcoincharts.com", 27007)
    
    #     thUSD          | 2011-06-27 23:00:55 | USD      | 17.05  | 0.5    |
    puts "Exchange       | Date and time       | Currency | Price  | Volume |"

    while data = @socket.gets do
      if data.length > 0
        begin
          j = JSON.parse(data.strip)
        rescue
        end
    
        if args.length == 0 or args.include?(j['symbol'].downcase) then
          line  = j['symbol'].ljust(15) + "| "
          line += Time.at(j['timestamp']).strftime("%Y-%m-%d %H:%M:%S").\
          ljust(20)
          line += "| " + j['currency'].ljust(9) + "| "
          line += j['price'].round(2).to_s.ljust(7) + "| "
          line += j['volume'].round(2).to_s.ljust(7) + "|"
    
          puts line
        end
      end
    end
  end
end