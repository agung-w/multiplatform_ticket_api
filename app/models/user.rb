class User < ApplicationRecord
    has_secure_password
    # has_many :credentials
    validates :name, length: { in: 3..60 },presence:true
    # validates :password, length: {in: 6..72}
    # validates :email,:name, presence: true
    validates :phone_number, uniqueness: true
    # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    # validates :phone,:numericality => true,:length => { :minimum => 10, :maximum => 15 }
    
    # def self.from_omniauth(response)
    #     User.find_or_create_by!(uid:response[:uid],provider:response[:provider]) do |u|
    #         u.name=response[:info][:name]
    #         u.email=response[:info][:email]
    #         u.image_url=response[:extra][:raw_info][:picture]
    #         u.password=SecureRandom.hex(15)
    #     end
    # end

end
