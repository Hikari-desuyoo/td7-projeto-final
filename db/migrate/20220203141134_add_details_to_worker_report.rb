class AddDetailsToWorkerReport < ActiveRecord::Migration[6.1]
  def change
    add_column :worker_reports, :last_refresh_at, :datetime
    add_column :worker_reports, :status, :int, default: 0
  end
end
