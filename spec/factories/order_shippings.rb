FactoryBot.define do
  factory :order_shipping do
    post_code {"123-4567"}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    municipalities {"横浜市緑区"}
    address {"青山1-1-1"}
    building {"柳ビル103"}
    telephone {"09012345678"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end