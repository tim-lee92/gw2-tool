class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
  end

  def new
    if current_user
      @post = Post.new
    else
      flash[:error] = 'You must be signed in to create a thread.'
      redirect_to posts_path
    end
  end

  def create
    if current_user
      @post = Post.new(params.require(:post).permit(:title, :body))
      @post.user_id = current_user.id
      if @post.save
        @post.save
        redirect_to post_path(@post.id)
      else
        @errors = @post.errors
        flash[:error] = 'Please check your errors:'
        render :new
      end
    else
      flash[:error] = 'You must be signed in to create a thread.'
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user
      if @post.user == current_user
        Post.delete(params[:id])
        flash[:notice] = "You have successfully delete thread: #{@post.title}"
        redirect_to posts_path
      end
    else
      flash[:error] = 'You must be signed in to do that.'
      redirect_to posts_path
    end
  end
end
