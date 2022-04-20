class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :food
  
  validates :quantity, presence: true
  
  enum product_status: { not_make: 0, wait: 1, making: 2, done: 3 }
  
  def add_tax_price
    (self.tital_price * 1.08).round
  end 
end
