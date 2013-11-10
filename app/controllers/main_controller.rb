class MainController < ApplicationController

	def index
		@bitcoins = Bitcoin.all.order(:created_at).select(:buy_price, :sell_price).collect{|bitcoin| [bitcoin.buy_price, bitcoin.sell_price]}
	end

end
