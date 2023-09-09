FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    explanation { 'ああ' }
    category_id { '2' }
    status_id { '2' }
    shipping_fee_id { '2' }
    prefecture_id { '2' }
    preparation_day_id { '2' }
    price { Faker::Number.number(digits: 4) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
