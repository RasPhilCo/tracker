module V1
  class TaskSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :state, :project_id
  end
end
