class PurchasesController < ApplicationController
  before_filter :is_the_current_user?
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!

  # GET /purchases
  # GET /purchases.json
  def index
    @user = current_user
    @purchases = @user.purchases.where(is_active: true)
    bitcoin_number = @purchases.sum(:quantity) || 0
    bitcoin_value = @purchases.collect{|bitcoin| bitcoin.amount * bitcoin.quantity}.first || 0


    @bitcoins = Bitcoin.all.order(:created_at).select(:id, :created_at, :buy_price, :sell_price).where('created_at >= ?', 24.hours.ago)    
    @chart = @bitcoins.collect{|bitcoin| [bitcoin.created_at.strftime('%l:%M %p'), ((bitcoin.sell_price.to_f / 100 * bitcoin_number) - bitcoin_value).round(3)]}.insert(0, ['Time', 'Outcome'])
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @user = current_user
    @purchase = @user.purchases.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  def create
    @user = current_user
    @purchase = @user.purchases.new(purchase_params)
    if @purchase.save
      redirect_to [@user, @purchase], notice: 'Purchase was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /purchases/1  
  def update    
      if @purchase.update(purchase_params)
        redirect_to [@user, @purchase], notice: 'Purchase was successfully updated.'        
      else
        render action: 'edit'      
      end    
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.update_attribute :is_active, false    
    redirect_to user_purchases_url(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @user = current_user
      @purchase = @user.purchases.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:amount, :quantity, :user_id, :is_active)
    end

    def is_the_current_user?
      redirect_to root_path and return if current_user != User.find(params[:user_id])
    end
  end

