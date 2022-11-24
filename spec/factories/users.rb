FactoryBot.define do
  factory :user do
    name { "agung" }
    email { "agung@gmail.com" }
    phone { "08122018185" }
    password {"123456"}
    reset_password_token { nil }
    reset_password_at { nil }
    image_url{"https://lh3.googleusercontent.com/a/ALm5wu1KD1rpd4qK9GoYDRBhAVs5Ita1dl943EVvsM43=s96-c"}
    uid{"103963926322513405162"}
    provider{"google_auth2"}
  end
end
