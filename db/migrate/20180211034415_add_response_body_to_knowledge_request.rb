class AddResponseBodyToKnowledgeRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :knowledge_requests, :response_body, :text
  end
end
