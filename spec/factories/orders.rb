FactoryBot.define do
  factory :order do
    order_id { "MyString" }
    movie_id { 1 }
    user { nil }
    studio { nil }
    quantity { 1 }
    sub_total { "9.99" }
    additional_charge { "9.99" }
    discount { "9.99" }
    status { "MyString" }
  end
end
