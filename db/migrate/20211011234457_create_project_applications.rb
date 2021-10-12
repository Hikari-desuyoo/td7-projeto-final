class CreateProjectApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :project_applications do |t|
      t.references :worker, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :status, default: 10

      t.timestamps
    end
  end
end
