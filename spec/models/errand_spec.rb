require 'rails_helper'

describe Errand, type: :mode do
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
    let(:errand) { build(:errand, params) }

    context "with valid params" do
      let(:params) { nil }
      it { expect(errand.valid?).to be_truthy }
    end

    context "without name" do
      let(:params) { { name: nil} }
      it { expect(errand.valid?).to be_falsy }
    end
  end

  describe "association with task model" do
    let(:errand) { create(:errand) }
    let(:errand_with_tasks) { create(:errand_with_tasks) }

    describe "the collection of tasks" do
      context "with no task" do
        it { expect(errand.tasks).to be_empty }
      end

      context "with tasks" do
        it { expect(errand_with_tasks.tasks).not_to be_empty }
      end
    end

    describe "duplicate task's name" do
      let(:name) { "duplicate_name" }
      let!(:exist_task) { create(:task,
                                 name: name,
                                 errand_id: errand.id) }

      context "when name has already used" do
        let(:task) { build(:task, name: name, errand_id: errand) }
        it { expect(task.valid?).to be_falsy }
      end
    end
  end
end
