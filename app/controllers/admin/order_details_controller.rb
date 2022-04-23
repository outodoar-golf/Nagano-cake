class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
  # 製作ステータス製作中を選択すると支払い方法を製作中にする
    if params[:order_detail][:product_status] == "making"
       order_detail.order.update(status: 2)
       redirect_to request.referer
  # 製作ステータス製作完了を選択すると。。。
    elsif params[:order_detail][:product_status] == "done"
  # OrderDetailのデータの中から、order_detail = OrderDetail.find(params[:id])のbelongs_toのIDを探して配列で取得
       lists = OrderDetail.where(order_id: order_detail.order.id)
       @count = 0
  # each文で1つづつ取り出して、product_statusが"done(製作完了)"であれば、@countに１を足す
       lists.each do |list|
         if list.product_status == "done"
           @count += 1
         end
       end
  #配列のcount数 == "done(製作完了)"であれば、@countに１を足していった値が同じ→全配列が"done"である
       if @count == lists.count
  # orderのステータスを発送準備に更新する。
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
