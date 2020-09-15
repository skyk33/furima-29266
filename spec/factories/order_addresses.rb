FactoryBot.define do
  factory :order_address do
    user_id { 1 }
    item_id { 1 }
    token { 'aaaaa' }
    post_code { '123-4567' }
    prefecture_id { 1 }
    city_town { '東京都' }
    street_number { '1-1-1' }
    building_name { 'テストビル3F' }
    phone_number { '09012345678' }
  end
end
