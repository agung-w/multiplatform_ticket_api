FactoryBot.define do
  factory :verification_code do
    user { nil }
    code { "MyString" }
    expire_at { "2022-12-04 20:41:51" }
  end
end
