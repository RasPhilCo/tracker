Swagger::Docs::Config.base_api_controller = ApplicationController
Swagger::Docs::Config.register_apis({
  '1.0' => {
    api_extension_type: :json,
    api_file_path: 'public/api',
    base_path: 'http://localhost:3000/',
    clean_directory: false,
    formatting: :pretty
  }
})

class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    path = "v1/projects/{project_id}/tasks" if (/^v1\/tasks$/).match(path)
    path
  end
end
