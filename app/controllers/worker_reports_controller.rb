class WorkerReportsController < ApplicationController
  skip_before_action :redirect_incomplete_workers

  def show
    @worker_report = WorkerReport.find(params[:id])
    fetch_last_refresh_at
  end

  def refresh
    @worker_report = WorkerReport.find(params[:id])
    @worker_report.start_refresh_job
    redirect_to @worker_report, notice: t('processing_refresh_notice')
  end

  private

  def fetch_last_refresh_at
    @last_refresh_at = if @worker_report.last_refresh_at.nil?
                         I18n.t('common.never')
                       else
                         I18n.l(@worker_report.last_refresh_at, format: :short)
                       end
  end
end
