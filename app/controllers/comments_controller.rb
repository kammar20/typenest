class CommentsController < ApplicationController
  before_action :set_blog
  before_action :require_user, only: [:create, :destroy]
  before_action :require_same_user, only: :destroy
  before_action :set_comment, only: [:edit, :update, :destroy]

  def edit
    
  end
  
  def update
    if @comment.update(comment_params)
      flash[:notice] = "Comment updated!"
      redirect_to blog_path(@blog)
    else
      flash[:alert] = "Something went wrong!"
      render :edit
    end
  end

  def create
    @comment = @blog.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "Comment added!"
      redirect_to blog_path(@blog)
    else
      flash[:alert] = "Something went wrong!"
      redirect_to blog_path(@blog)
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to blog_path(@blog)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def set_comment
    @comment = @blog.comments.find(params[:id])
  end

  def require_same_user
    if current_user != @comment.user
      flash[:alert] = "You can only delete your own comments"
      redirect_to blog_path(@blog)
    end
  end
end
