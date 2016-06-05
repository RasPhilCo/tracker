class DomainWorldDriver < WorldDriver

  def initialize
    p 'Running Features in the Domain World'
    super
  end

  def request_list collection_type, params
    @results, e = "List#{collection_type.camelize}".constantize.new(params).call
    @errors.push *e
  end

  def request_nested_list collection_type, parent_type, params
    parent = "#{parent_type.capitalize}".constantize.find_by(id: params["#{parent_type}_id".to_sym])
    if parent.nil?
      e = ["Project not found"]
      @errors.push *e
    else
      # remove <parent_type>_id, leaving page query params
      params = params.select{|x| !(x ==  "#{parent_type}_id".to_sym) }
      @results, e = "List#{collection_type.camelize}".constantize.new(parent, params).call
      @errors.push *e
    end
  end

  def create_project params
    project = Project.create params
    @errors.push *project.errors.full_messages
  end

  def create_task params
    task = Task.create params
    @errors.push *task.errors.full_messages
  end

  def get_task_from_project params
    task_id, project_id = params[:id], params[:project_id]
    @results = Task.find_by id: task_id, project_id: project_id
    if @results.nil?
      e = ["Task not found"]
      @errors.push *e
    else
      @results = V1::TaskSerializer.new(@results).attributes
    end
  end
end
