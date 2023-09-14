FactoryBot.define do
  factory :purchase_record do
    postal_code    { '123-4567' }
    prefecture     { 48 }
    city           { 'うるま市' }
    address        { 'みどり町1-1-1' }
    building_name  { '東棟' }
    phone_number   { '09012345678' }
    association :user # Userと関連付け
    association :item # Itemと関連付け
  end
end
