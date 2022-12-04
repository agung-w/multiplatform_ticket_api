class VerificationCode < ApplicationRecord
  belongs_to :user
  def self.generate(user)
    VerificationCode.create(
      user_id:user.id,
      code:"#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}",
      expire_at:Time.now+600)
  end
  def self.verify(user_id,code)
    code = self.find_by(user_id:user_id,code:code)
  end
end
