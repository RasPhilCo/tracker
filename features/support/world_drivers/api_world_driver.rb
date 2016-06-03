class ApiWorldDriver < WorldDriver
  include Rack::Test::Methods

  def initialize
    p 'Running Features in the API World'
    super
  end

  def app
    Rails.application
  end

  def request_list collection_type, params
    result = get "/v1/#{collection_type}?#{params.to_query}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def request_nested_list collection_type, parent_type, params
    parent_id = params["#{parent_type}_id".to_sym]
    params = params.select{|x| !(x ==  "#{parent_type}_id".to_sym )}
    results = get "/v1/#{parent_type.pluralize}/#{parent_id}/#{collection_type}?#{params.to_query}"
    body = JSON.parse(results.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      @results = body
    end
  end

  def create_project attributes
    result = post '/v1/projects', {project: attributes}
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def create_task attributes
    project_id = attributes[:project_id]

    result = post "/v1/projects/#{project_id}/tasks", {task: attributes}
    body = JSON.parse(result.body).deep_symbolize_keys

    if body[:errors].present?
      @errors.push *body[:errors]
    end
  end

  def get_task_from_project attributes
    project_id, task_id = attributes[:project_id], attributes[:id]
    result = get "/v1/projects/#{project_id}/tasks/#{task_id}"
    body = JSON.parse(result.body).deep_symbolize_keys
    if body[:errors].present?
      @errors.push *body[:errors]
      @results = nil
    else
      # ignore/remove timestamps
      task = body.select{|x| ![:created_at, :updated_at].include?(x) }
      @results = task
    end
  end
end
