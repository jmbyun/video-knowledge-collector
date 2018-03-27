class AddCallbackUrlToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :callback_url, :string
  end
end
