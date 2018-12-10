class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :status_verification

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_id, :name, :phone, :cpf, :country, :zipcode, :mibank])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :country, :zipcode])
  end

  def status_verification
    if user_signed_in?
      redirect_to root_path if current_user.blocked?
    end
  end
end
