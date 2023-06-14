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

  with_options presence: true do
  validates :image, presence: { message: "を選択してください" }
  validates :name
  validates :explain
  validates :price
  end

  with_options numericality: { other_than: 1 , message: "を選択してください"} do
  validates :category_id
  validates :condition_id
  validates :load_id
  validates :prefecture_id
  validates :delivery_day_id
  end

  validates :price, numericality: 
  { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
  message: 'は￥300から￥9,999,999の範囲で半角数字で入力してください' }, allow_blank: true
end

