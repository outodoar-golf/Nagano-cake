class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :food
  
  def add_tax_price
    (self.tital_price * 1.08).round
  end 
end
