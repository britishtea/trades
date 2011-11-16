require 'json'

class Trade
  attr_reader :id
  attr_reader :market
  attr_reader :timestamp
  attr_reader :currency
  attr_reader :volume
  
  attr_accessor :price
  
  def initialize(data)
    parsed      = JSON.parse data.strip.tr("\x00", '')
    @id         = parsed['id']
    @market     = parsed['symbol']
    @timestamp  = parsed['timestamp']
    @currency   = parsed['symbol'][-3, 3]
    @price      = parsed['price']
    @volume     = parsed['volume']
  end
  
  def timestamp(show_date = false)
    format = show_date ? "%Y-%m-%d %H:%M:%S" : "%H:%M:%S"
    Time.at(@timestamp).strftime(format)
  end
  
  def price(decimals = 4)
    @price.round(decimals)
  end
  
  def to_s
    "#{@market.ljust(15)} | #{timestamp()} | #{@currency.ljust(9)} | " +
    "#{price().to_s.ljust(9)} | #{@volume.to_s}"
  end
end