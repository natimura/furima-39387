class OrderShipping
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :order_id, :post_code, :prefecture_id, 
  :municipalities, :address, :building, :telephone

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :order_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/,
    message: "郵便番号は半角で○○○-○○○○と入力して下さい"}
    validates :prefecture_id
    validates :municipalities
    validates :address

    validates :telephone_validates
      def telephone_validates
        telephone_fix=telephone.gsub(/-/, '')
        unless telephone_fix.match?(/\A[0-9]{10,11}\z/)
          errors.add(:telephone, "電話番号は半角数字で入力してください")
        end
      end
  end

  def save
    order=Order.create(user_id: user_id, item_id: item_id)
    shipping=Shipping.cteate(order_id: order.id, post_code: post_code, 
    prefecture_id: prefecture_id, municipalities: municipalities, address: address,
    building: building, telephone: telephone)
  end

end


    
