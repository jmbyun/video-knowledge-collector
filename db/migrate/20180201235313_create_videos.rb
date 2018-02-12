class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :path
      t.belongs_to :project, foreign_key: true
      t.text :knowledge_body

      t.timestamps
    end
  end
end
