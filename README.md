Install
=======

You'll need [Rubygems](https://rubygems.org/pages/download). After Rubygems is installed, type `gem install trades` or `sudo gem install trades` if the former gives you errors.

Usage
=====

The gem comes with an executable. To display trades from all the exchanges Bitcoincharts monitors.

	trades

You can also display trades from specified exchanges only. You'll need to make sure you use the same name that Bitcoincharts uses. The arguments are case-insensitive and you can specify as many as you want.

	trades mtgoxUSD thUSD

If you want to use trades in your own project, you can initialize a new session with `Trades.new ['mtgoxUSD', 'other_exchanges']`. It won't be very useful, though.

Data
====

All data is provided by [Bitcoincharts.com](http://bitcoincharts.com/), via their telnet API socket thing.

License
=======

Dunno, as long as you don't sell it for monies you can do anything you want with it.