# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  project_id  :uuid
#  name        :string
#  description :string
#  state       :integer          default(1)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#

class Task < ActiveRecord::Base
  belongs_to :project

  validates :project, presence: { message: "can't be blank or invalid"}
  validates :name, presence: true
  validates :state, presence: true

  after_initialize :set_default_state

  enum state: {
    todo: 1,
    'in-progress': 10,
    done: 20
  }

  private

  def set_default_state
    self.state ||= :todo
  end
end
