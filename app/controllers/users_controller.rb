class UsersController < ApplicationController
  skip_before_action :verify_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash.notice = "Thanks for signing up. Welcome to the club!"
      login(user)
      redirect_to root_path
    else
      flash.notice = user.errors.full_messages.join(', ')
      redirect_to signup_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
