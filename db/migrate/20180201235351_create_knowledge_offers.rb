class CreateKnowledgeOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :knowledge_offers do |t|
      t.string :id_str
      t.string :description
      t.string :callback_url
      t.boolean :approved
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
