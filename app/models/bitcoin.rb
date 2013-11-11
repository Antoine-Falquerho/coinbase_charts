class Bitcoin < ActiveRecord::Base
	def self.fetch_prices		
		coinbase = Coinbase::Client.new(nil)
		Bitcoin.create buy_price: coinbase.buy_price.cents, sell_price: coinbase.sell_price.cents
	end
end
