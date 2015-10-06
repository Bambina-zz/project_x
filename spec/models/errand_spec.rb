require 'rails_helper'

describe Errand, :type => :model do
  describe "transaction" do
    it "has one after adding one" do
      skip
      ##TODO: get rid of :set_dummy_user_id
      owner = create(:user)
      create(:errand, owner_id: owner.id)
      expect(Errand.count).to eq owner.id
    end
  end

  describe "callback" do
    it "applies :set_dummy_user_id" do
      errand = build(:errand)
      expect(errand).to receive( :set_dummy_user_id )
      errand.valid?
    end

    it "applies :generate_shared_hash" do
      errand = build( :errand, shared_hash: nil )
      expect(errand).to receive(:generate_shared_hash)
      errand.valid?
    end

    it "sets SecureRandom's uuid to shared_hash" do
      generated_hash = '4b58ba16-89f6-4138-a384-e2ca211e9550'

      allow(SecureRandom).to receive(:uuid) { generated_hash }
      errand = build(:errand)
      errand.valid?

      expect(errand.shared_hash).to eq generated_hash
    end
  end

  describe "validation" do
    it "is valid with a name" do
      expect(build(:errand)).to be_valid
    end

    it "is invalid without name" do
      errand = build( :errand, name: nil )
      errand.valid?
      expect(errand.errors[:name]).to include("can't be blank")
    end
  end
end
