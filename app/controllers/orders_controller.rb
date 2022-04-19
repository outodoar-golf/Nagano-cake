class OrdersController < ApplicationController

  def new
    @new_order = Order.new
    @orders = Order.all
    @address = Address.new
    @addresses = current_customer.addresses.all
  end


  def confirm
    params[:payment_method] = params[:payment_method].to_i
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        @order.shipping_price = 800
        @cart_foods = current_customer.cart_foods
        @order.total_price = 0
        if params[:order][:address_option]== "0"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.last_name + current_customer.first_name

        elsif params[:order][:address_option]== "1"
          @list_address = Address.find_by(params[:order][:address])
          @order.postal_code = @address.postal_code
          @order.address = @address.address
          @order.name = @address.name
        end

  end


  def create
     order = Order.new(order_params)
     order.customer_id = current_customer.id
     order.save
     current_customer.cart_foods.each do |cart_food|
       order_detail = OrderDetail.new
       order_detail.food_id = catr_food.food_id
       order_detail.quantity = cart_food.quantity
       order_detail.price = cart_food.food.price
       order_detail.save
       end
       redirect_to complete_orders_path
  end


  def index
     @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end



  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_price, :payment_method, :total_price, :status)
  end
end
