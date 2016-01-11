class LinksController < ApplicationController

  def index
    @links = current_user.links.sort
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

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    link = Link.find_by(id: params[:id])
    if params[:update_what] == "read_status"
      link.update(read: !link.read)
    elsif params[:link][:update_what] == "content"
      link.update(link_params)
    end
    flash.notice = "Couldn't complete that edit because " + link.errors.full_messages.join(', ')
    redirect_to links_path
  end

  private

    def link_params
      params.require(:link).permit(:title, :url, :user_id)
    end

end
