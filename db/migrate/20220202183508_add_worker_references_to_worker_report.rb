class AddWorkerReferencesToWorkerReport < ActiveRecord::Migration[6.1]
  def change
    add_reference :worker_reports, :worker, null: false, foreign_key: true
  end
end
