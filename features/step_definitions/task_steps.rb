When(/^I create a task for a project with:$/) do |table|
  attributes = vertical_table table
  d.create_task attributes
end

Then(/^the project has the task:$/) do |table|
  ActiveCucumber.diff_all! Project.first.tasks, table
end

Then(/^the system has (\d+) tasks?$/) do |count|
  expect(Task.count).to eq count.to_i
end

Given(/^a task for a project:$/) do |table|
  d.given_task table
end

When(/^I request the task:$/) do |table|
  attributes = vertical_table table
  d.get_task_from_project attributes
end

Given(/^(\d+) tasks for a project:$/) do |count, table|
  attributes = vertical_table table
  d.given_tasks_for_project count: count, project_id: attributes[:project_id]
end
