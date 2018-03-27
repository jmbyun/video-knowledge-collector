json.extract! project, :id, :id_str, :title, :description, :callback_url, :video_list, :user_id, :created_at, :updated_at
json.url project_url(project, format: :json)
