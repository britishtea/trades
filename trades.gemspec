Gem::Specification.new do |s|
  s.name        = 'trades'
  s.version     = '0.1.2'
  s.summary     = "Nice trading data"
  s.description = "Displays the trades that Bitcoincharts monitors nicely"
  s.authors     = ["Waxjar"]
  s.files       = ["lib/trades.rb"]
  s.executables << 'trades'
  
  s.add_runtime_dependency 'json', '~> 1.5.3'
end