class CartFood < ApplicationRecord
  belongs_to:customer
  belongs_to:food
  validates :quantity,presence: true
   ## 小計を求めるメソッド
  def subtotal
    food.with_tax_price * quantity
  end
end
