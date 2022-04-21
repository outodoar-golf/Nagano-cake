class Admin::OrderDetailsController < ApplicationController

  def update
   @order_details = OrderDetail.find(params[:id])

    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    if @order_detail.making_status == "製作中"
      @order.update(product_status: 2)
      @order.save
    end

    if @order.order_detail.count == @order.order_detail.where(making_status: 3).count
      @order.update(product_status: 3)
      @order.save
    end

    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :product_status)
  end
end
