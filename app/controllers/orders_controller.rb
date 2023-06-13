class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: :index

  def index
    @order_shipping=OrderShipping.new
  end

  def create
    @order_shipping=OrderShipping.new(order_params)
    if @order_shipping.valid?
      card_params
      @order_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, 
    :municipalities, :address, :building, :telephone).merge(
    user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def card_params
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, 
      card: order_params[:token], 
      currency: 'jpy')
  end

  def set_item
    @item=Item.find(params[:item_id])
  end

  def move_to_index
    @orders=Order.all
    if current_user.id == @item.user_id || @orders.exists?(item_id: @item.id)
      redirect_to root_path
    end
  end

end
