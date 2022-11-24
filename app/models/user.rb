class User < ApplicationRecord
    has_secure_password
    has_many :credentials
    def self.from_omniauth(response)
        User.find_or_create_by(uid:response[:uid],provider:response[:provider]) do |u|
            u.name=response[:info][:name]
            u.email=response[:info][:email]
            u.image_url=response[:extra][:raw_info][:picture]
            u.password=SecureRandom.hex(15)
        end
    end
end
