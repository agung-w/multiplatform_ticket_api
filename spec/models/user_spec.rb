require 'rails_helper'

RSpec.describe User, type: :model do
  context "name attribute" do
    it "is invalid when value is null" do
      user=FactoryBot.build(:user,name:nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid when value length is < 3" do
      user=FactoryBot.build(:user,name:"a")
      user.valid?
      expect(user.errors[:name]).to include("is too short (minimum is 3 characters)")
    end

    it "is invalid when value length is > 60" do
      user=FactoryBot.build(:user,name:"a"*61)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 60 characters)")
    end

  end
  
  context "email attribute" do
    it "is invalid when value is null" do
      user=FactoryBot.build(:user,email:nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid when value is not in email format" do
      user=FactoryBot.build(:user,email:"agung")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "is invalid when value duplicated" do
      user=FactoryBot.create(:user)
      user2=FactoryBot.build(:user)
      user2.valid? 
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context "phone attribute" do
    it "is invalid when value is null" do
      user=FactoryBot.build(:user,phone:nil)
      user.valid?
      expect(user.errors[:phone]).to include("can't be blank")
    end

    it "is invalid when value is not in phone number format" do
      user=FactoryBot.build(:user,phone:"081a")
      expect(user).not_to be_valid
    end

    it "is invalid when value duplicated" do
      user=FactoryBot.create(:user)
      user2=FactoryBot.build(:user)
      user2.valid? 
      expect(user2.errors[:phone]).to include("has already been taken")
    end
  end

  context "password attribute" do
    it "is invalid when value is null" do
      user=FactoryBot.build(:user,password:nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid when value length is < 6" do
      user=FactoryBot.build(:user,password:"asd")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "is invalid when value length is > 150" do
      user=FactoryBot.build(:user,password:"a"*151)
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 72 characters)")
    end
  end
end
