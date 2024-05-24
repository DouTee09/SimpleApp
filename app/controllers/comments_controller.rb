class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params);
    @micropost = Micropost.find_by id: comment_params[:micropost_id]
    if @comment.save
      flash[:success] = "Comment created !!!"
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "Failed to create comment !!!"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:micropost_id, :content)
    end
end
