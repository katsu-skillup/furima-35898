class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_delivery = OrderDelivery.new(delivery_params)
    if @order_delivery.valid?
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

  def delivery_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :city, :address,:building, :phone_number, :order_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
