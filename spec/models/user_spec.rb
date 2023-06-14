require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "email、password、password_confirmation、nickname、first_name、
        last_name、first_name_kana、last_name_kan、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname=''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it "emailが空では登録できない" do
        @user.email=''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email='test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it "passwordが空では登録できない" do
        @user.password=''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password='12345'
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end
     
      it 'passwordは半角英字が含まれていないと登録できない' do
        @user.password =111111
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて入力してください")
      end

      it 'passwordは半角数字が含まれていないと登録できない' do
        @user.password ="aaaaaa"
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて入力してください")
      end

      it 'passwordに半角英数字以外が含まれている場合登録できない' do
        @user.password ="111aaaあ"
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて入力してください")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name=''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)を入力してください")
      end
      
      it 'last_nameが空では登録できない' do
        @user.last_name=''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)を入力してください")
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名)は全角文字で入力してください")
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(姓)は全角文字で入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana=''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)を入力してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana=''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)を入力してください")
      end

      it 'first_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名)はカナ文字で入力してください")
      end

      it 'last_name_kanaは全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(姓)はカナ文字で入力してください")
      end

      it 'birthdayが空では登録できない' do
        @user.birthday=''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
