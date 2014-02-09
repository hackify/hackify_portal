class CommentsController < ApplicationController
  before_filter :store_return_to
  before_filter :authenticate 
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.create!(comment_params)
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.html { redirect_to @event }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
