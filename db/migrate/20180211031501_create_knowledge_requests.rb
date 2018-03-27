class CreateKnowledgeRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledge_requests do |t|
      t.string :url
      t.boolean :succeed
      t.belongs_to :knowledge_offer, foreign_key: true

      t.timestamps
    end
  end
end
