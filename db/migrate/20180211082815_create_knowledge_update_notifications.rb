class CreateKnowledgeUpdateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledge_update_notifications do |t|
      t.string :url
      t.boolean :succeed
      t.belongs_to :video, foreign_key: true

      t.timestamps
    end
  end
end
