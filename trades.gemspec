Gem::Specification.new do |s|
  s.name        = 'trades'
  s.version     = '1.0.1'
  s.authors     = ["Waxjar"]
  s.homepage    = "https://github.com/britishtea/Trades"
  s.summary     = "Bitcoin trading data on the command line"
  s.description = "Displays the trading data that Bitcoincharts monitors nicely"
  s.requirements << "Ruby version 1.9.2 or higher"

  s.files       = Dir["lib/trades.rb", "lib/trades/*"]
  s.test_files  = ["tests/trade.rb"]
  s.executables << 'trades'
  
  s.add_runtime_dependency 'bundler', '~> 1.0'
  s.add_runtime_dependency 'colored', '~> 1.2'
  s.add_runtime_dependency 'json', '~> 1.6.1'
end