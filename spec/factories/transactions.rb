FactoryBot.define do
  factory :transaction do
    order { nil }
    user { nil }
    type { "" }
    total { "9.99" }
    status { "MyString" }
  end
end
