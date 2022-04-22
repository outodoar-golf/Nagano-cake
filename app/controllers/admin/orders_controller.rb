class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(10)
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
    @order_details.each do |order_detail|
      @sum += order_detail.subtotal
    end
    @shipping_price = 800
    @total_price = @sum + @shipping_price
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

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to request.referer
  end


  private

  def order_params
    params.require(:order).permit(:last_name,:first_name,:postal_code,:address,:payment_method,:status,:quantity)
  end
end
