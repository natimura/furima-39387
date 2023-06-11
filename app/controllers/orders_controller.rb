class OrdersController < ApplicationController
  def index
    @order_shipping=OrderShipping.new
  end

  def create
    @order_shipping=OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      redirect_to root_path
    else
      render :index
  end

end
