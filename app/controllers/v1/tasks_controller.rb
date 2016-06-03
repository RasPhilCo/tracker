module V1
  class TasksController < ApplicationController
    swagger_controller :projects, 'Tasks'

    swagger_api :index do
      summary 'List all tasks for a project'
      notes 'This lists all the tasks for a project'
      param :path, :project_id, :string, :required, 'Project id'
      param :query, :page, :integer, :optional, 'page number of results, default 1'
      param :query, :page_size, :integer, :optional, 'number of results per page, default 25'
    end
    def index
      project = Project.find_by id: params[:project_id]
      if project.present?
        tasks, errors = ListTasks.new(project, index_params).call
        if errors.any?
          render json: { errors: errors }, status: 400
        else
          render json: tasks
        end
      else
        render json: { errors: ['Project not found', 'Tasks not found'] }, status: 404
      end
    end

    swagger_api :show do
      summary 'Fetch a single Task for a project'
      param :path, :id, :string, :required, 'Task Id'
      param :path, :project_id, :string, :required, 'Project id'
    end
    def show
      task = Task.find_by id: params[:id]
      if task.present? && task.project_id == params[:project_id]
        render json: task
      else
        render json: { errors: ['Task not found'] }, status: 404
      end
    end

    swagger_api :create do
      summary 'Creates a new Task for a project'
      param :form, :name, :string, :required, 'Task name'
      param :form, :description, :string, :optional, 'Task description'
      param :form, :project_id, :string, :required, 'Project id'
    end
    def create
      task = Task.new task_params
      if task.save
        render json: task, status: 201
      else
        render json: { errors: task.errors.full_messages }, status: 400
      end
    end

    private

    def index_params
      params.permit(:page, :page_size).to_h.symbolize_keys
    end

    def task_params
      (params.require(:task).permit :name, :description, :state).merge(project_id: params[:project_id])
    end
  end
end
