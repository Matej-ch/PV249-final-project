class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email,
                                                            :first_name,
                                                            :last_name,
                                                            :nick_name,
                                                            :password) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,
                                                            :first_name,
                                                            :last_name,
                                                            :nick_name,
                                                            :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email,
                                                                   :first_name,
                                                                   :last_name,
                                                                   :nick_name,
                                                                   :password) }
  end
end
