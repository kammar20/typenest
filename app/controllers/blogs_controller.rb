class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.paginate(page: params[:page], per_page: 6)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
  
    if @blog.save
      flash[:notice] = "Blog created successfully."
      redirect_to @blog
    else
      render "new"
    end
  end

  def show
    @likes = @blog.likes
  end
  
  def edit

  end

  def update
    if @blog.update(blog_params)
      flash[:notice] = "Blog updated successfully."
      redirect_to @blog
    else
      render "edit"
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = "Blog was successfully deleted."
    redirect_to blogs_path
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    permitted = [:title, :description]
  
    if params[:image].present?
      permitted << :image
    end
  
    params.permit(permitted)
  end

  def require_same_user
    if current_user != @blog.user
      flash[:alert] = "You can only edit or delete your own blog"
      redirect_to blog_path(@blog)
    end
  end
  

end
