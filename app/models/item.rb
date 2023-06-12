class Item < ApplicationRecord

  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :load
  belongs_to :prefecture
  belongs_to :delivery_day

  validates :image, :name, :explain, presence: true

  validates :price, presence: true, numericality: 
  { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
  message: '￥300から￥9,999,999の範囲で半角数字で入力してください' }

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :load_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_day_id, numericality: { other_than: 1 , message: "can't be blank"}

end

