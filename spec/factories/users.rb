FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { 'Password123' } 
    password_confirmation { 'Password123' } 
    last_name_full_width { person.last.kanji }
    first_name_full_width { person.first.kanji }
    last_name_full_width_katakana { person.last.katakana }
    first_name_full_width_katakana { person.first.katakana }
    birthday { Faker::Date.backward }
  end
end