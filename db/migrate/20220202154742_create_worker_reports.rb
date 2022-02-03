class CreateWorkerReports < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_reports do |t|
      t.integer :project_count, default: 0
      t.integer :best_scored_project_id
      t.integer :worst_scored_project_id
      t.timestamps
    end

    add_foreign_key :worker_reports, :projects, column: :best_scored_project_id
    add_foreign_key :worker_reports, :projects, column: :worst_scored_project_id
  end
end