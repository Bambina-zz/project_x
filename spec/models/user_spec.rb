require 'rails_helper'

describe User, :type => :model do
  describe "transaction" do
    it "has none to begin with" do
      expect(User.count).to eq 0
    end

    it "has one after adding one" do
      create(:user)
      expect(User.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(User.count).to eq 0
    end
  end

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
    pending("Add NOT NULL constraint to password_confirmation")
    user = build( :user, password_confirmation: nil )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    duplicate_email = 'a@example.com'

    create( :user, email: duplicate_email )
    second_user = build( :user, email: duplicate_email )
    second_user.valid?
    expect(second_user.errors[:email]).to include("has already been taken")
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
end
