# frozen_string_literal: true

# Controller for Companies
class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to @company
    else
      render 'new'
    end
  end

  # File after submission in edit.html.erb
  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to company_url(@company)
    else
      render 'edit'
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :ceo, :company_id, :ceo_gender, :ceo_race, :stock_isin,
                                    :ceo_annual_salary, :ceo_annual_bonus, :ceo_annual_sold_shares,
                                    :ceo_annual_stock_award, :ceo_shares)
  end
end
