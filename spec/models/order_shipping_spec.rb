require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    user=FactoryBot.create(:user)
    item=FactoryBot.create(:item)
    @order_shipping=FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入ができる場合' do
      it "post_code、prefecture_id、municipalities、address、telephone、token
      が正しく処理されていれば購入できる" do
        expect(@order_shipping).to be_valid
      end

      it 'buildingは空でも購入できること' do
        @order_shipping.building=''
        expect(@order_shipping).to be_valid
      end
    end

    context '商品購入ができない場合' do
      it "post_codeが空では購入できない" do
        @order_shipping.post_code=''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'post_codeに半角文字列以外が含まれている場合購入できない' do
        @order_shipping.post_code="１２３ー４５６７"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号は半角で○○○-○○○○と入力してください")
      end

      it 'post_codeに-が含まれていない場合購入できない' do
        @order_shipping.post_code=1234567
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号は半角で○○○-○○○○と入力してください")
      end

      it 'post_codeが7文字以下では購入できない' do
        @order_shipping.post_code="123-456"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号は半角で○○○-○○○○と入力してください")
      end

      it 'post_codeが9文字以上では購入できない' do
        @order_shipping.post_code="123-45678"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号は半角で○○○-○○○○と入力してください")
      end

      it 'prefecture_idが1では購入できない' do
        @order_shipping.prefecture_id=1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("都道府県を選択してください")
      end

      it "municipalitiesが空では購入できない" do
        @order_shipping.municipalities=''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("市区町村を入力してください")
      end

      it "addressが空では購入できない" do
        @order_shipping.address=''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("番地を入力してください")
      end

      it "telephoneが空では購入できない" do
        @order_shipping.telephone=''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'telephoneに半角数字以外が含まれている場合購入できない' do
        @order_shipping.telephone="０９０１２３４５６７８"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は-を入れず半角数字で入力してください")
      end

      it 'telephoneが9桁以下では購入できない' do
        @order_shipping.telephone="090123456"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は-を入れず半角数字で入力してください")
      end

      it 'telephoneが12桁以上では購入できない' do
        @order_shipping.telephone="090123456789"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は-を入れず半角数字で入力してください")
      end

      it 'userが紐付いていないと購入できない' do
        @order_shipping.user_id=nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと購入できない' do
        @order_shipping.item_id=nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では購入できない' do
        @order_shipping.token=nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("クレジットカード情報を正しく入力してください")
      end
    end
  end
end
