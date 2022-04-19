class Order < ApplicationRecord
  has_many :order_details,dependent: :destroy
  belongs_to :customer
  has_one_attached :image
  
  def full_name
    customer.first_name + customer.last_name
  end

  enum payment_method: { credit_card: 0, transfer: 1}
  
  enum status: { waiting_payment: 0, payment_confirm: 1, making: 2, before_sent: 3, sent: 4 }

  def add_tax_price
    (self.tital_price * 1.08).round
  end
end
