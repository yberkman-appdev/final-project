class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:username, :gender])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:username, :gender])
  end
  skip_before_action :verify_authenticity_token, raise: false
end
