class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :edit, :destroy]
  before_action :require_user, except: [:index, :show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 6)
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "User signed up successfully"

      # Redirect to the stored forwarding URL (if it exists), or default to the user profile page
      if session[:forwarding_url].present? && session[:intended_action] == 'like'
        blog_id = session[:blog_id]  # Retrieve blog_id from session
        @blog = Blog.find_by(id: blog_id)
        if @blog && !@blog.liked_by?(@user)
          @blog.likes.create(user_id: @user.id)
        end
        session.delete(:forwarding_url)
        session.delete(:intended_action)
        session.delete(:blog_id)  # Clear blog_id from session
        redirect_to blog_path(@blog) and return
      elsif session[:forwarding_url].present?
        redirect_to session.delete(:forwarding_url)  # Ensure it gets cleared after being used
      else
        redirect_to user_path(@user)
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def show
    @blogs = @user.blogs.paginate(page: params[:page], per_page: 4)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associated Blogs are deleted"
    redirect_to root_path
  end

  private 

  def user_params
    params.permit(:username, :email, :usertitle, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to user_path(@user)
    end
  end
end
