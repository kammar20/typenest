class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      
      Rails.logger.debug "session[:forwarding_url] in SessionsController#create: "+session[:forwarding_url].to_s
      Rails.logger.debug "session[:intended_action] in SessionsController#create: "+session[:intended_action].to_s
      Rails.logger.debug "session[:blog_id] in SessionsController#create: "+session[:blog_id].to_s

      if session[:forwarding_url].present? && session[:intended_action] == 'like'
        blog_id = session[:blog_id]  # Retrieve blog_id from session
        @blog = Blog.find_by(id: blog_id)
        if @blog && !@blog.liked_by?(current_user)
          @blog.likes.create(user_id: current_user.id)
        end
        session.delete(:forwarding_url)
        session.delete(:intended_action)
        session.delete(:blog_id)  # Clear blog_id from session
        redirect_to blog_path(@blog) and return
      end

      # Redirect to the stored forwarding URL, or default to the user's profile
      redirect_to session.delete(:forwarding_url) || user_path(user)
    else
      flash.now[:alert] = "Login credentials are incorrect"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end
end
