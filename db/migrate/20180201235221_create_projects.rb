class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :id_str
      t.string :description
      t.text :video_list
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
