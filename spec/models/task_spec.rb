require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:project).with_message(/can't be blank or invalid/) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :state }
  it { should belong_to(:project) }

  let (:task) { build(:task) }

  it "should be in the default state 'todo" do
    expect(task.state).to eq("todo")
  end

  it "should be in the state 'in-progress'" do
    task.state = :'in-progress'
    expect(task.state).to eq("in-progress")
  end

  it "should be in the state 'done'" do
    task.state = :done
    expect(task.state).to eq("done")
  end
end
