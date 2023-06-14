class OrderShipping
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, 
  :municipalities, :address, :building, :telephone, :token

  with_options presence: true do
    validates :token, presence: { message: "を正しく入力してください" }
    validates :user_id
    validates :item_id
    validates :post_code
    validates :prefecture_id
    validates :municipalities
    validates :address
    validates :telephone
  end

  validates :prefecture_id, numericality: { other_than: 1 ,
  message: "を選択してください"}

  with_options allow_blank: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/,
    message: "は半角で○○○-○○○○と入力してください"}
    validates :telephone, format: {with: /\A[0-9]{10,11}\z/,
    message: "は-を入れず半角数字で入力してください"}
  end

  def save
    order=Order.create(user_id: user_id, item_id: item_id)
    shipping=Shipping.create(order_id: order.id, post_code: post_code, 
    prefecture_id: prefecture_id, municipalities: municipalities, address: address,
    building: building, telephone: telephone)
  end

end


    
