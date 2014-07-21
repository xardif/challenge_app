class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :can_accept_answer?
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :avatar, :login, :provider, :uid, :email, :password, :password_confirmation) }
	    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :login, :provider, :uid, :email, :password) }
	    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :avatar, :login, :provider, :uid, :email, :password, :password_confirmation, :current_password) }
	  end

  private

	  def can_accept_answer?(answer)
      current_user == @question.user && current_user != answer.user &&
       !current_user.blank? && !@question.accepted_answer_id
    end
end