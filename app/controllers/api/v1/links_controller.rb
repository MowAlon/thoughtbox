class Api::V1::LinksController < ApplicationController
  respond_to :json

  def update
    link = Link.find_by(id: params[:id])
    response, status = if link.update(read: !link.read)
      [link, 200]
    else
      flash.notice = errors.full_messages.join(', ')
      [flash.notice, 400]
    end
    render json: response, status: status
  end

  # def index
  #   ideas = Idea.all.order('created_at ASC')
  #   respond_with Idea.new.ideas_with_tags(ideas)
  # end
  #
  # def show
  #   idea = Idea.find_by(id: params[:id])
  #   respond_with idea.idea_with_tags
  # end
  #
  # def create
  #   new_idea = Idea.new(idea_params.except("tags"))
  #   if new_idea.save
  #     save_tags(new_idea)
  #     render json: new_idea.idea_with_tags, status: 200
  #   else
  #     render json: new_idea.errors, status: 400
  #   end
  # end

  # def destroy
  #   deleted_idea = Idea.find_by(id: params[:id]).destroy
  #   if deleted_idea
  #     render json: deleted_idea, status: 200
  #   else
  #     render json: deleted_idea.errors, status: 400
  #   end
  # end

  private

    def idea_params
      params.permit(:title, :description, :tags)
    end

    # def save_tags(idea)
    #   Tag.add_new_tags(params[:tags], idea) if !params[:tags].empty?
    # end

end
