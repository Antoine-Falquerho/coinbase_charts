class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception  
  helper_method :current_price

  private  

  def current_price
  	@current_price = Bitcoin.order(:created_at).select(:created_at, :buy_price, :sell_price).last
  end
end
