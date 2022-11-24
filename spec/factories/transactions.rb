FactoryBot.define do
  factory :transaction do
    order { 1 }
    user { 1 }
    type { "" }
    total { "9.99" }
    status { "MyString" }
  end
end
