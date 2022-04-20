class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
  end

  def create
    order = Order.find(params[:id])
    @order_foods = @order.order_foods
    order.update(order_params)
    if @order.status == "入金待ち"
      @order_details.update_all(product_status: 1)
    end
      redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:last_name,:first_name,:postal_code,:address,:payment_method,:status,:quantity)
  end
end
