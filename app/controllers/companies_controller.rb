# frozen_string_literal: true

# Controller for Companies
class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to @company
    else
      render 'new'
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :ceo, :company_id, :start_date, :end_date)
  end
end
