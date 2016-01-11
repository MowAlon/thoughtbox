class SessionsController < ApplicationController
  skip_before_action :verify_user, only: [:new, :create]

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    user = User.find_by(email:  user_params[:email])
    if user && user.authenticate(user_params[:password])
      login(user)
      redirect_to links_path
    else
      flash.notice = "Invalid credentials. Try again, poser."
      redirect_to login_path
    end

  end

  def destroy
    flash.notice = "Successfully logged out. See ya next time!" if session.clear
    redirect_to login_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
