require 'ostruct'
require 'logger'

class TradeOptions
  # Define markets, market aliases and currencies
  MARKETS    = %w[mtgoxUSD thUSD mtgoxEUR virwoxSLL mtgoxGBP intrsngGBP 
    virtexCAD btceUSD cbxUSD btcexUSD btcdeEUR wbxAUD mtgoxRUB bitmarketEUR 
    mtgoxPLN thEUR mtgoxCAD intrsngUSD mtgoxAUD intrsngEUR btcnCNY thAUD 
    bitstampUSD mtgoxHKD intsngPLN bitmarketUSD bitnzNZD thLRUSD thINR rockSSL 
    mtgoxSGD b2cUSD aqoinEUR mtgoxSEK ruxumUSD thCLP mrcdBRL mtgoxCNY mtgoxCHF 
    mtgoxDKK bitfloorUSD ruxumJPY bitmarketAUD mtgoxJPY ruxumZAR bitmarketPLN 
    ruxumSEK ruxumRUB rockEUR mtgoxNZD rockUSD ruxumCHF bbmBRL globalPLN 
    globalGBP bitmarketRUB ruxumHUF mtgoxTHB ruxumAUD ruxumEUR globalEUR 
    bitmarketGBP ruxumGBP ruxumPLN ruxumSGD ruxumTHB ruxumUAH globalUSD]
  ALIASES    = {"mtgox" => "mtgoxUSD", "th" => "thUSD", "tradehill" => "thUSD"}
  CURRENCIES = {
    "usd" => "USD", "dollar" => "USD", "us" => "USD",
    "eur" => "EUR", "euro" => "EUR", "euros" => "EUR",
    "gbp" => "GBP", "pound" => "GBP",
    "ssl" => "SSL", "secondlife" => "SSL",
    "cny" => "CNY", 
    "cad" => "CAD", "canadian" => "CAD",
    "aud" => "AUD", "australian" => "AUD", "aus" => "AUD",
    "rub" => "RUB", "russian" => "RUB", "rubble" => "RUB",
    "pln" => "PLN", "polish" => "PLN",
    "hkd" => "HKD", "hongkong" => "HKD",
    "nzd" => "NZD", "newzealand" => "NZD", "nz" => "NZD",
    "sgd" => "SGD",
    "sek" => "SEK",
    "clp" => "CLP",
    "brl" => "BRL",
    "chf" => "CHF",
    "dkk" => "DKK",
    "jpy" => "JPY", "yen" => "JPY", "japan" => "JPY",
    "zar" => "ZAR",
    "huf" => "HUF",
    "thb" => "THB",
    "uah" => "UAH"
  }

  def self.parse(args)
    # Default options
    options            = OpenStruct.new
    options.filter     = :markets
    options.markets    = []
    options.currencies = []
    options.color      = true

    opts = OptionParser.new do |opts|
    	opts.banner = "Usage: trades [options]\n\n"

      opts.separator "Options:"

      # Filter on market
      opts.on("-m", "--market MARKET", MARKETS, ALIASES, 
        "Filter on MARKET") do |m|
        options.markets << m # << because of multiple currencies
      end

      # Filter on currency
      opts.on("-c", "--currency CURRENCY", CURRENCIES.values.uniq, CURRENCIES, 
    	  "Filter on CURRENCY") do |c|
    	  options.filter = :currencies # default is :markets
    	  options.currencies << c # << because of multiple currencies
      end

    	# Logging
    	opts.on("-l", "--log [FILENAME]", "Log the results to FILENAME") do |file|
    		file = "/var/log/trades.log" if file.nil?
    		options.log    = true
    		options.logger = Logger.new File.new(file, 'a+')
    		options.logger.formatter = proc { |s, d, p, m| "#{m}\n" }
    	end
    	
    	# No-color
    	opts.on_tail("--no-color", "Plain text instead of output colorized") do
    	  options.color = false
  	  end
      
      # List of markets
      opts.on_tail("--markets", "Show a list of all markets") do
        puts "Markets: #{MARKETS.join ', '}\n\nAliases:"
        ALIASES.each { |x,y| puts "#{x} for #{y}" }
        exit
      end
      
      # List of currencies
      opts.on_tail("--currencies", "Show a list of all currencies") do
        puts "Currencies: #{CURRENCIES.values.uniq.join ', '}"
        exit
      end
      
      # Help
      opts.on_tail("-h", "--help", "Show this message") do
        puts "#{opts}\n\nMore info: https://github.com/britishtea/Trades"
        exit
      end
    end

    opts.parse!(args)
    options
  end
end 