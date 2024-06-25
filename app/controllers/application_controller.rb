# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[zipcode address introduction])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[zipcode address introduction])
  end
end
