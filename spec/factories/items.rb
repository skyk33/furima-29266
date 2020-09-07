FactoryBot.define do
  factory :item do
    name { 'test' }
    description { Faker::Lorem.sentence }
    category_id { 1 }
    condition_id { 1 }
    delivery_charge_type_id { 1 }
    delivery_schedule_id { 1 }
    prefecture_id { 1 }
    price { 300 }
    association :user
  end
end
