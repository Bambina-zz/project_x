require 'rails_helper'

describe Errand, :type => :model do
  describe "transaction" do
    it "has none to begin with" do
      expect(Errand.count).to eq 0
    end

    it "has one after adding one" do
      # TODO "get rid of set_dummy_user_id callback in app/models/errand.rb"
      owner = create(:user)
      create(:errand, owner_id: owner.id)
      expect(Errand.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(Errand.count).to eq 0
    end
  end

  it "is valid with a name, owner_id and shared_hash" do
    expect(build(:errand)).to be_valid
  end

  it "is invalid without name" do
    errand = build( :errand, name: nil )
    errand.valid?
    expect(errand.errors[:name]).to include("can't be blank")
  end

  it "is invalid without owner_id" do
    pending("get rid of set_dummy_user_id in app/models/errand.rb")
    errand = build( :errand, owner_id: nil )
    errand.valid?
    expect(errand.errors[:owner_id]).to include("can't be blank")
  end

  it "is invalid without shared_hash" do
    pending("how to test this?")
    errand = build( :errand, shared_hash: nil )
    errand.valid?
    expect(errand.errors[:shared_hash]).to include("can't be blank")
  end
end
