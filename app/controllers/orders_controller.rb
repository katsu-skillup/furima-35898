class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :cheack_authority]
  before_action :cheack_authority
 

  def index
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(delivery_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end
  
  
  private
  
  def delivery_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :city, :address,:building, :phone_number ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: delivery_params[:token],
      currency: 'jpy'
    )
  end
    
  def set_item
    @item = Item.find(params[:item_id])
  end

  def cheack_authority
    if set_item.user_id == current_user.id || Item.find(params[:item_id]).order != nil
      redirect_to root_path
    end
  end
  
end
