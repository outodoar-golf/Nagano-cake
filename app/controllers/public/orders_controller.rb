class Public::OrdersController < ApplicationController

  def new
    @new_order = Order.new
    @orders = Order.all
    @address = Address.new
    @addresses = current_customer.addresses.all
  end


  def confirm
        @order = Order.new(order_params)
        @customer = current_customer
        @cart_foods = current_customer.cart_foods
        @total = @cart_foods.inject(0) { |sum, item| sum + item.subtotal }
        @order.shipping_price = 800
        @sum = (@total + @order.shipping_price)

        if params[:order][:address_option] == "0"
          @order.postal_code = @customer.postal_code
          @order.address = @customer.address
          @order.name = @customer.last_name + @customer.first_name
          @order.total_price = @sum
        elsif params[:order][:address_option] == "1"
          @address = Address.find_by(id: params[:order][:address_form])

          if @address == nil
            flash[:danger] = ["登録先住所が選択されていません"]
            redirect_to request.referer
          else
            @order.postal_code = @address.postal_code
            @order.address = @address.address
            @order.name = @address.name
            @order.total_price = @sum
          end
        elsif params[:order][:address_option] == "2"
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
          @order.total_price = @sum
        end
  end


  def create
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      if @order.save
         current_customer.cart_foods.each do |cart_food|
           order_detail = OrderDetail.new
           order_detail.food_id = cart_food.food_id
           order_detail.quantity = cart_food.quantity
           order_detail.price = cart_food.food.price
           order_detail.order_id = @order.id
           order_detail.product_status = 0
           order_detail.save
           current_customer.cart_foods.destroy_all
         end
         redirect_to public_order_complete_path(@order.id)
      else
          flash[:danger] = @order.errors.full_messages
          redirect_to new_public_order_path
      end
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



