class Order < ApplicationRecord
  has_many :order_details,dependent: :destroy
  belongs_to :customer
  has_one_attached :image

  enum payment_method: { credit_card: 0, transfer: 1}
  
  

  def add_tax_price
    (self.tital_price * 1.08).round
  end
end
