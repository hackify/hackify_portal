class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = @event.comments.create!(comment_params)
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
