class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    if !@comment.save && current_user
      flash[:error] = 'Comments cannot be blank'
    end

    if !current_user
      flash[:error] = 'You must be signed in to comment.'
    end
    
    redirect_to(post_path(@comment.post))
  end
end
