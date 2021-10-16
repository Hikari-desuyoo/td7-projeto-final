class AddDeclineReasonToProjectApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :project_applications, :decline_reason, :text
  end
end
