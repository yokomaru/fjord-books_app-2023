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

  def after_sign_up_path_for(*)
    root_path
  end

  def after_sign_in_path_for(*)
    books_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end
end
