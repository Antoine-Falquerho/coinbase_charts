class MainController < ApplicationController

	def index
		@bitcoins = Bitcoin.all.order(:created_at).select(:id, :created_at, :buy_price, :sell_price).where('created_at >= ?', 24.hours.ago)
		@to_buy = @bitcoins.order(:buy_price).first
		@to_sell = @bitcoins.order(:sell_price).last
		@chart = @bitcoins.collect{|bitcoin| [bitcoin.created_at.strftime('%l:%M %p'), bitcoin.buy_price.to_f / 100, bitcoin.sell_price.to_f / 100]}.insert(0, ['Time', 'Buy amount', 'Sell amount'])		
	end

end
