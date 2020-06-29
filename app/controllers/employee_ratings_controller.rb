# frozen_string_literal: true

# Controller for Employee Ratings
class EmployeeRatingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy edit update]

  # File after submission in new.html.erb
  def create
    @company = Company.find(params[:company_id])
    @employee_rating = @company.employee_ratings.create(employee_ratings_params)
    @employee_rating.user_id = current_user.id

    if @employee_rating.save
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  # File after clicking delete
  def destroy
    @company = Company.find(params[:company_id])
    @employee_rating = EmployeeRating.find(params[:id])
    redirect_invalid_users
    @employee_rating.destroy

    redirect_to company_path(@company)
  end

  # Setup prior to loading edit.html.erb
  def edit
    @company = Company.find(params[:company_id])
    @employee_rating = EmployeeRating.find(params[:id])
  end

  # Setup prior to loading new.html.erb
  def new
    @company = Company.find(params[:company_id])
    @user = current_user
    @employee_rating = EmployeeRating.new
  end

  # File after submission in edit.html.erb
  def update
    @employee_rating = EmployeeRating.find(params[:id])
    redirect_invalid_users

    if @employee_rating.update(employee_ratings_params)
      redirect_to company_path(@employee_rating.company_id)
    else
      render 'edit'
    end
  end

  private

  def redirect_invalid_users
    return if current_user.id == @employee_rating.user_id

    flash[:error] = "You cannot access someone else's ratings!"
    redirect_to company_path
  end

  def employee_ratings_params
    params.require(:employee_rating).permit(:headline, :value, :pros, :cons, :discriminated,
                                            :discriminated_by_management, :harassed, :harassed_by_management,
                                            :housework_required, :included)
  end
end
