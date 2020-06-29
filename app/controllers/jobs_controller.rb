# frozen_string_literal: true

# Controller for Jobs
class JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
    redirect_invalid_users
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id

    if @job.save
      redirect_to jobs_path
    else
      render 'new'
    end
  end

  def update
    @job = Job.find(params[:id])
    redirect_invalid_users

    if @job.update(job_params)
      redirect_to jobs_path
    else
      render 'edit'
    end
  end

  def destroy
    @job = Job.find(params[:id])
    redirect_invalid_users
    @job.destroy

    redirect_to jobs_path
  end

  private

  def redirect_invalid_users
    return if current_user.id == @job.user_id

    flash[:error] = "You cannot access someone else's jobs."
    redirect_to root_path
  end

  def job_params
    params.require(:job).permit(:title, :pay_rate, :pay_period, :start_date, :end_date, :company_id)
  end
end
