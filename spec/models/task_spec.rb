require 'rails_helper'

describe Task, type: :model do
  describe "transaction" do
    it "has one after adding one" do
      tasks_count = Task.count
      create(:task)
      expect(Task.count).to eq tasks_count + 1
    end
  end

  describe "validation" do
    let(:task) { build(:task, params) }

    context "with valid params" do
      let(:params) { nil }
      it { expect(task.valid?).to be_truthy }
    end

    context "without name" do
      let(:params) { {name: nil} }
      it { expect(task.valid?).to be_falsy }
    end

    context "without errand_id" do
      let(:params) { {errand_id: nil} }
      it { expect(task.valid?).to be_falsy }
    end

    context "when done is neither TRUE nor FALSE" do
      let(:params) { {done: nil} }
      it { expect(task.valid?).to be_falsy }
    end
  end
end
