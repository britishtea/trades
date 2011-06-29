Installation
============

You'll need [Rubygems](https://rubygems.org/pages/download). After Rubygems is installed, type `gem install trades` or `sudo gem install trades` if the former gives you errors.

Usage
=====

The trades gem comes with an executable. To run it, simply type `trades`. Type `trades mtgoxUSD thUSD` to only display the trades of Mt. Gox and Trade Hill. You can specify as many markets as you want, as long as you make sure you use the same name [Bitcoincharts](http://bitcoincharts.com/) uses. 

If you want to use trades in your own project, you can initialize a new session with `Trades.new ['mtgoxUSD', 'other_exchanges']`. It won't be very useful, though.

License
=======

All data is provided by [Bitcoincharts.com](http://bitcoincharts.com/), via their telnet interface. As long as you don't sell Trades for monies you can do anything you want with it, except for rape.