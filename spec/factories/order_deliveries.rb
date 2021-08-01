FactoryBot.define do
  factory :order_delivery do  
      postal_code               { '123-4567' }
      prefecture_id             { Faker::Number.between(from: 2, to: 48) }
      city                      { '江東区' }
      address                   { '1-1-1' }
      building                  { 'ビル' }
      phone_number              { '09012345678' }
  end
end
