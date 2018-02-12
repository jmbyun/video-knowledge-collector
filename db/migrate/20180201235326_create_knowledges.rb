class CreateKnowledges < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledges do |t|
      t.text :body
      t.belongs_to :video, foreign_key: true
      t.belongs_to :knowledge_offer, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
