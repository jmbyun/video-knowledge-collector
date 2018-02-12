json.extract! knowledge_offer, :id, :id_str, :description, :callback_url, :approved, :project_id, :user_id, :created_at, :updated_at
json.url knowledge_offer_url(knowledge_offer, format: :json)
