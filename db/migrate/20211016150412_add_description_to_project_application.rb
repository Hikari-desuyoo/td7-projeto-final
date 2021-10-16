class AddDescriptionToProjectApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :project_applications, :description, :text
  end
end
