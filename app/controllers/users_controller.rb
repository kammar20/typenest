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
      flash[:notice] = "User signed Up successfully"
      redirect_to user_path(@user)
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