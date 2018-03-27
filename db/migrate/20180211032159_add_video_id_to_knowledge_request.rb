class AddVideoIdToKnowledgeRequest < ActiveRecord::Migration[5.1]
  def change
    add_reference :knowledge_requests, :video, index: true
  end
end
