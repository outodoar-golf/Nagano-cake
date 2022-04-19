class Food < ApplicationRecord
  has_one_attached:image
  belongs_to:genre
  has_many:cart_foods
  validates :name,presence: true
  validates :explanation,presence: true
  validates :price,presence: true
  validates :image,presence: true



  # ステータスが販売中か販売中しか判別するメソッド
  def get_status(number)
    if number == true
      "販売中"
    else
      "販売停止中"
    end
  end
  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

  # 投稿画像が表示されなかった時にサンプルを表示するメソッド（今回はnullを許可していない為いらない？）
  # def get_image(width,height)
  #   unless image.attached?
  #     file_path = Rails.root.join("app/assets/images/ファイル名")
  #     image.attach(io:File.open(file_path).filename:"default-image.jpg",content_type:"image/jpeg")
  #   end
  #   image.variant(resize_to_limit:[width,height]).processed
  # end
end
