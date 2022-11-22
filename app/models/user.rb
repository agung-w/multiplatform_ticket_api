class User < ApplicationRecord
    has_secure_password
    has_many :credentials
    def self.from_omniauth(response)
        User.find_or_create_by(uid:response[:uid],provider:response[:provider]) do |u|
            u.username=response[:info][:name]
            u.email=response[:info][:email]
            u.password=SecureRandom.hex(15)
            u.credentials.access_token=response[:credentials][:token]
            u.credentials.refresh_token=response[:credentials][:refresh_token]
        end
    end
end
