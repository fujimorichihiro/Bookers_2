class ApplicationController < ActionController::Base

  before_action :authenticate_user!
# ログイン後のリダイレクト先
  def after_sign_in_path_for(resourse)
  	user_path(current_user)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    #strong parametersを設定し、nameを許可
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name, :password, :password_confirmation) }
  end
end
