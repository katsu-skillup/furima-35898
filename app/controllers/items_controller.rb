class ItemsController < ApplicationController
  before_action :cheack_authority, only: [:edit, :update] 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

 private
  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end

  def cheack_authority
    if user_signed_in?
      if Item.find(params[:id]).user_id != current_user.id
        redirect_to root_path
      end
    end
  end     
end
