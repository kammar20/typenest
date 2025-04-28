class LikesController < ApplicationController
  before_action :require_user

  def create
    @blog = Blog.find(params[:blog_id])

    if logged_in?
      # User is logged in, perform the like action
      unless @blog.liked_by?(current_user)
        @blog.likes.create(user_id: current_user.id)
      end
      redirect_to blog_path(@blog)
    else
      # Store the intended action and blog ID in session
      Rails.logger.debug "Setting session[:forwarding_url] to: "+blog_path(@blog)
      Rails.logger.debug "Setting session[:intended_action] to: like"
      Rails.logger.debug "Setting session[:blog_id] to: "+@blog.id.to_s
      session[:forwarding_url] = blog_path(@blog)
      session[:intended_action] = 'like'
      session[:blog_id] = @blog.id
      # Redirect to login page
      byebug
      redirect_to login_path
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    like = @blog.likes.find_by(user_id: current_user.id)
    like.destroy if like
    redirect_to blog_path(@blog)
  end
end
