FactoryBot.define do
  factory :user do
    email {Faker::Internet.free_email}
    password {"a1"+Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    nickname {Faker::Name.last_name}
    first_name {"山田"}
    last_name {"太郎"}
    first_name_kana {"ヤマダ"}
    last_name_kana {"タロウ"}
    birthday {"2000-01-01"}
  end
end

