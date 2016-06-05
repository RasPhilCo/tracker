FactoryGirl.define do
  factory :task do
    project nil
    name "My important task"
    description "Import task description"
    state 1
  end
end
