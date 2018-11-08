class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:email, :username, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :account_update, keys: [:email, :username, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :remember_me]
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:username]
  end
end
