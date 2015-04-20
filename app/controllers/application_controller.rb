class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def logged_in?
    !!current_user
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    access_denied 'This action is reserved for registered users only. Please sign in/up.' unless logged_in?
  end

  def access_denied(msg)
    flash[:info] = msg
    redirect_to root_path
  end
end
