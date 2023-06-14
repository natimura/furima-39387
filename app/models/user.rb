class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, 
  message: 'は全角文字で入力してください' }, allow_blank: true do
    validates :last_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー]+\z/, 
  message: 'はカナ文字で入力してください' }, allow_blank: true do
    validates :last_name_kana
    validates :first_name_kana
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, 
  message: 'には英字と数字の両方を含めて入力してください', allow_blank: true
  
  has_many :items
  has_many :orders

end
