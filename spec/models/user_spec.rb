require 'rails_helper'

describe User, type: :model do
  describe "transaction" do
    it "has one after adding one" do
      users_count = User.count
      create(:user)
      expect(User.count).to eq users_count + 1
    end
  end

  describe "validation" do
    let(:user) { build(:user, params) }

    context "with valid params" do
      let(:params) { nil }
      it { expect(user.valid?).to be_truthy }
    end

    context "without name" do
      let(:params) { {name: nil} }
      it { expect(user.valid?).to be_falsy }
    end

    context "without email" do
      let(:params) { {email: nil} }
      it { expect(user.valid?).to be_falsy }
    end

    context "without password" do
      let(:params) { {password: nil} }
      it { expect(user.valid?).to be_falsy }
    end

    context "without password_confirmation" do
      let(:params) { {password_confirmation: nil} }
      it { expect(user.valid?).to be_falsy }
    end

    context "when password and password_confirmation are not equal" do
      let(:params) { {password: '123456', password_confirmation: '654321'} }
      it { expect(user.valid?).to be_falsy }
    end

    context "when password's character is less than 5 letters" do
      let(:params) { {password: '12345', password_confirmation: '12345'} }
      it { expect(user.valid?).to be_falsy }
    end

    context "when admin is neither TRUE nor FALSE" do
      let(:params) { {admin: nil} }
      it { expect(user.valid?).to be_falsy }
    end

    describe "duplicate email address" do
      let(:email) { "a@example.com" }
      let!(:exist_user) { create(:user, email: email) }

      context "when email has already taken" do
        let(:user) { build(:user, email: email) }
        it { expect(user.valid?).to be_falsy }
      end

      context "with UPPER CASE email" do
        let(:user) { build(:user, email: email.upcase ) }
        it { expect(user.valid?).to be_falsy }
      end
    end

    describe "email format" do
      let(:user) { build(:user) }

      context "with valid email format" do
        it "is valid" do
          addresses = %w[useUPCASE@foo.COM use_UNDERSCORE-DASH@f.b.org first.last@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            user.email = valid_address
            expect(user.valid?).to be_truthy, "#{user.email} should be VALID!"
          end
        end
      end

      context "with invalid email format" do
        it "is invalid" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
          addresses.each do |valid_address|
            user.email = valid_address
            expect(user.valid?).to be_falsy, "#{user.email} should be INVALID!"
          end
        end
      end
    end
  end

  describe "#authenticate" do
    let!(:user) { create(:user) }
    let(:exist_user) { User.find_by( email: user.email ) }

    context "with the CORRECT password" do
      it { expect( exist_user.authenticate(user.password) ).to be_truthy }
    end

    context "with the WRONG password" do
      it { expect( exist_user.authenticate("wrong_password") ).to be_falsy }
    end
  end
end
