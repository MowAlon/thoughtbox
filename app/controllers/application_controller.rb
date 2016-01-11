class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :verify_user

  def verify_user
    if !current_user
      flash.notice = "Do me a favor. Log in before you do anything else."
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
  end

end
