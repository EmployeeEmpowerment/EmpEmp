# frozen_string_literal: true

# Controller for Application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    sanitize_params(:sign_up)
    sanitize_params(:account_update)
  end

  def sanitize_params(action)
    %i[name private year_of_birth gender race lgbtqia_plus immigrant expat has_disability
       veteran].each do |k|
      devise_parameter_sanitizer.permit(action, keys: [k])
    end
  end
end
