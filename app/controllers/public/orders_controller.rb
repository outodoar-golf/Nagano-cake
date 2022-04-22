class Public::OrdersController < ApplicationController

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

        if params[:order][:address_option]== "0"
          @sum = 0
          current_customer.cart_foods.each do |item|
            @sum  += item.subtotal
          end
          @order.total_price = @sum + 800
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.last_name + current_customer.first_name

        elsif params[:order][:select_address] == "1"
          address = Address.find(params[:order][:address_id])
          @order.postal_code = address.postal_code
          @order.address = address.address
          @order.name = address.name
        elsif params[:order][:select_address] == "2"
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        end
  end


  def create
      order = Order.new(order_params)
      order.customer_id = current_customer.id
      order.save
      current_customer.cart_foods.each do |cart_food|
       order_detail = OrderDetail.new
       order_detail.food_id = cart_food.food_id
       order_detail.quantity = cart_food.quantity
       order_detail.price = cart_food.food.price
       order_detail.order_id = order.id
       order_detail.product_status = 0
       order_detail.save
      end
       redirect_to public_order_complete_path(order.id)
  end


  def index
     @orders = current_customer.orders.all
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



