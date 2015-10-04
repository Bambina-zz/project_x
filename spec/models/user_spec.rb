require 'rails_helper'

describe User do
  it "is valid with a name, email, password and password_confirmation" do
    user = User.new(
      name: 'mayu',
      email: 'a@example.com',
      password: '123456',
      password_confirmation: '123456' )
    expect(user).to be_valid
  end

  it "is invalid without name" do
    user = User.new( name: nil )
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without email" do
    user = User.new( email: nil )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = User.new( password: nil )
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without password_confirmation" do
    pending("Add NOT NULL constraint to password_confirmation")
    user = User.new( password_confirmation: nil )
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    duplicate_email = 'a@example.com'

    User.create(
      name: 'first',
      email: duplicate_email,
      password: '123456',
      password_confirmation: '123456' )

    user = User.new(
      name: 'second',
      email: duplicate_email,
      password: '123456',
      password_confirmation: '123456' )

    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
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
