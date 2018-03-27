class ChangePathToUrlForVideo < ActiveRecord::Migration[5.1]
  def change
    rename_column :videos, :path, :url
  end
end
