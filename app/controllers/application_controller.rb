class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    movies_path
  end

  def after_sign_up_path_for(resource)
    movies_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def redirect_to_with_302(options = {}, response_status = {})
      response_status[:status] ||= :found
      redirect_to options, response_status.merge(status: :found)
  end
end
