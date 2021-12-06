class WorkersController < ApplicationController
  before_action :authenticate_right_worker!, only: %i[edit update]
  skip_before_action :redirect_incomplete_workers, only: [:complete_profile]

  def complete_profile
    unless worker_signed_in?
      redirect_to root_path
      return
    end

    @current_worker = current_worker
    @current_worker.update(worker_params)

    unless @current_worker.complete_profile?
      redirect_to root_path, alert: t('alert.profile_still_incomplete')
      return
    end

    redirect_to root_path
  end

  def show
    @worker = Worker.find(params[:id])
    unless @worker.complete_profile?
      if current_worker then flash[:alert] = t 'alert.profile_still_incomplete' end
      redirect_to root_path
      return
    end

    set_feedback_attributes
    set_favorite_attributes
  end

  def edit
    @occupations = Occupation.all
    @current_worker = current_worker
  end

  def update
    @current_worker = current_worker
    @current_worker.update(edit_worker_params)

    redirect_to @current_worker
  end

  private

  def set_feedback_attributes
    @worker_average_score = @worker.worker_feedbacks.average(:score)
    @your_feedback = @worker.get_feedback_by current_hirer
    @feedbacks = @worker.worker_feedbacks

    if @worker_average_score.nil? then @worker_average_score = '-' end
  end

  def set_favorite_attributes
    @show_favorite_button = @worker.favorited_by?(current_hirer) == false
    @show_unfavorite_button = @worker.favorited_by?(current_hirer) == true
  end

  def edit_worker_params
    params.require(:worker).permit(
      :education,
        :description,
        :experience,
        :occupation_id
    )
  end

  def worker_params
    params.require(:worker).permit(
      :name,
        :surname,
        :social_name,
        :birth_date,
        :education,
        :description,
        :experience,
        :occupation_id
    )
  end
end
