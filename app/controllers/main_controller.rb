class MainController < ApplicationController

	def index
		@bitcoins = Bitcoin.all.order(:created_at).select(:id, :created_at, :buy_price, :sell_price).last(100).collect{|bitcoin| [bitcoin.created_at.strftime('%l:%M %p'), bitcoin.buy_price / 100, bitcoin.sell_price / 100]}
		@bitcoins.insert(0, ['Time', 'Buy amount', 'Sell amount'])
	end

end
