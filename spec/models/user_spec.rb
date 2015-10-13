require 'rails_helper'

describe User, type: :model do
  describe "transaction" do
    it "has one after adding one" do
      create(:user)
      expect(User.count).to eq 1
    end
  end

  describe "validation" do
    it "is valid with a name, email, password and password_confirmation" do
      expect(build(:user)).to be_valid
    end

    it "is invalid without name" do
      user = build( :user, name: nil )
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is invalid without email" do
      user = build( :user, email: nil )
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without password" do
      user = build( :user, password: nil )
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid without password_confirmation" do
      user = build( :user, password_confirmation: nil )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it "is invalid when password and password_confirmation are not equal" do
      user = User.new(
        password: '123456',
        password_confirmation: '654321p' )
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid when password's character is less than 5 letters" do
      user = User.new( password: '12345' )
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    describe "duplicate email address" do
      before do
        @duplicate_address = 'a@example.com'
        create( :user, email: @duplicate_address )
      end

      it "is invalid" do
        second_user = build( :user, email: @duplicate_address )
        second_user.valid?
        expect(second_user.errors[:email]).to include("has already been taken")
      end

      it "is invalid when it has UPPER CASE letters" do
        second_user = build( :user, email: @duplicate_address.upcase )
        second_user.valid?
        expect(second_user.errors[:email]).to include("has already been taken")
      end
    end

    describe "email format" do
      before do
        @user = create( :user )
      end

      it "is valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end

      it "is invalid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
  end

  describe "#authenticate" do
    before { @user = create(:user) }
    let(:found_user) { User.find_by( email: @user.email ) }

    it "returns @user with the CORRECT password" do
      expect(found_user.authenticate(@user.password)).to eq @user
    end

    it "returns false with the WRONG password" do
      expect(found_user.authenticate("wrong_password")).to be false
    end
  end
end
