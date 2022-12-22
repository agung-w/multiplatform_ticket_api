FactoryBot.define do
  factory :ticket do
    order_id { 1 }
    user_id { 1 }
    cinema_id { 1 }
    studio_id { 1 }
    schedule { "MyString" }
    seat { "MyString" }
  end
end
