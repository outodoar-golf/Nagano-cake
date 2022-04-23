class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    if params[:order_detail][:product_status] == "making"
       order_detail.order.update(status: 2)
       redirect_to request.referer
    elsif params[:order_detail][:product_status] == "done"
       lists = OrderDetail.where(order_id: order_detail.order.id)
       @count = 0
       lists.each do |list|
         if list.product_status == "done"
           @count += 1
         end
       end
       if @count == lists.count
          order_detail.order.update(status: 3)
          redirect_to request.referer
      else
          redirect_to request.referer
      end
    else
         redirect_to request.referer
    end

    # redirect_to request.referer
  end
  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :product_status)
  end
end
