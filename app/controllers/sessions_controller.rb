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
    user = User.find_by(name:  user_params[:name])
    # require 'pry'; binding.pry
    if user && user.authenticate(user_params[:password])
      login(user)
      redirect_to root_path
    else
      flash.notice = user.errors.full_messages.join(', ')
      redirect_to login_path
    end

  end

  def destroy

  end

  private

    def user_params
      params.require(:user).permit(:name, :password)
    end

end
