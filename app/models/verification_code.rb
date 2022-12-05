class VerificationCode < ApplicationRecord
  belongs_to :user
  def self.generate(user)
    VerificationCode.create(
      user_id:user.id,
      phone_number:user.phone_number,
      code:"#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}",
      expire_at:Time.now+600)
  end
  def self.verify(phone_number,code)
    code = self.find_by(phone_number:phone_number,code:code)
  end
end
