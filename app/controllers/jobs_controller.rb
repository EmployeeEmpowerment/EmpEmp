# frozen_string_literal: true

# Controller for Jobs
class JobsController < ApplicationController
  def index
    @user = User.find(params['user_id'])
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id

    if @job.save
      redirect_to user_jobs_path(current_user.id)
    else
      render 'new'
    end
  end

  def update
    @job = Job.find(params[:id])
    @job.user_id = current_user.id

    if @job.update(job_params)
      redirect_to user_jobs_path(current_user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    redirect_to user_jobs_path(current_user.id)
  end

  private

  def job_params
    params.require(:job).permit(:title, :pay_rate, :pay_period, :start_date, :end_date, :company_id)
  end
end
