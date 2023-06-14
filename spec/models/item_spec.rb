require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができる場合' do
      it "name、explain、category_id、condition_id、load_id、prefecture_id、
      delivery_day_id、priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do
      it "imageが空では出品できない" do
        @item.image=nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を選択してください")
      end

      it "nameが空では出品できない" do
        @item.name=''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it "explainが空では出品できない" do
        @item.explain=''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it "priceが空では出品できない" do
        @item.price=''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'priceに半角数字以外が含まれている場合出品できない' do
        @item.price="１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は￥300から￥9,999,999の範囲で半角数字で入力してください")
      end

      it 'priceが299以下では出品できない' do
        @item.price=299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は￥300から￥9,999,999の範囲で半角数字で入力してください")
      end

      it 'priceが10,000,000以上では出品できない' do
        @item.price=10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は￥300から￥9,999,999の範囲で半角数字で入力してください")
      end

      it 'category_idが1では出品できない' do
        @item.category_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it 'condition_idが1では出品できない' do
        @item.condition_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it 'load_idが1では出品できない' do
        @item.load_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end

      it 'prefecture_idが1では出品できない' do
        @item.prefecture_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end

      it 'delivery_dayが1では出品できない' do
        @item.delivery_day_id=1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'userが紐付いていないと出品できない' do
        @item.user=nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end