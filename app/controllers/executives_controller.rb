# frozen_string_literal: true

# Controller for Executives
class ExecutivesController < ApplicationController
  # File after submission in new.html.erb
  def create
    @company = Company.find(params[:company_id])
    @executive = @company.executives.create(executive_params)
    redirect_to company_path(@company)
  end

  def destroy
    @company = Company.find(params[:id])
    @executive = Executive.find(params[:id])
    @executive.destroy
    redirect_to company_path(@company)
  end

  # Setup prior to loading edit.html.erb
  def edit
    @company = Company.find(params[:company_id])
    @executive = Executive.find(params[:id])
  end

  # Setup prior to loading new.html.erb
  def new
    @company = Company.find(params[:company_id])
    @executive = Executive.new
  end

  # File after submission in edit.html.erb
  def update
    @company = Company.find(params[:company_id])
    @executive = Executive.find(params[:id])

    if @executive.update(executive_params)
      redirect_to company_path(@company)
    else
      render 'edit'
    end
  end

  private

  def executive_params
    params.require(:executive).permit(:name, :title, :gender, :race, :start_date)
  end
end
