require 'rails_helper'

describe Task, :type => :model do
  describe "transaction" do
    it "has none to begin with" do
      expect(Task.count).to eq 0
    end

    it "has one after adding one" do
      create(:task)
      expect(Task.count).to eq 1
    end

    it "has none after one was created in a previous example" do
      expect(Task.count).to eq 0
    end
  end

  it "is valid with a name, task_id and done" do
    expect(build(:task)).to be_valid
  end

  it "is invalid without name" do
    task = build( :task, name: nil )
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end

  it "is invalid without errand_id" do
    task = build( :task, errand_id: nil )
    task.valid?
    expect(task.errors[:errand_id]).to include("can't be blank")
  end

  it "is invalid when done is neither TRUE nor FALSE" do
    task = build( :task, done: nil )
    task.valid?
    expect(task.errors[:done]).to include("is not included in the list")
  end
end
