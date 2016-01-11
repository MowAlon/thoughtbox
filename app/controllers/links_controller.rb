class LinksController < ApplicationController

  def index
    @links = current_user.links
    @user_id = session[:user_id]
  end

  def create
    link = Link.new(link_params)
    if link.save
      flash.notice = "Added one more to the pile!"
      redirect_to links_path
    else
      flash.notice = "Couldn't add that because " + link.errors.full_messages.join(', ')
      redirect_to links_path
    end
  end

  private

    def link_params
      params.require(:link).permit(:title, :url, :user_id)
    end

end
