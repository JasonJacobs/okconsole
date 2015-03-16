class PostsController < ApplicationController
#Need to give access to images, languages, input
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
  skip_before_action :authenticate_user!, only: [:new, :copy_sessions, :graphics, :graphics_sessions]

  def index
    @posts = Post.all
    # Need to only render text if given, not "/posts/xx"
    render "posts/feed"
  end

  def show
    render 'posts/show'
  end

  def new
    @post = Post.new
    render 'posts/emotions'
  end

  def create
    @post = current_user.posts.build#(post_params)
    @post.top_copy = session[:top_copy]
    @post.bottom_copy = session[:bottom_copy]
    if @post.save
     redirect_to @post
    else
      render 'emotions'
    end
  end

  def edit
    # Need to lock this so people can't alter old posts
    render 'posts/input'
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Edited"
    else
      render 'posts/input'
    end
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  def copy_sessions
    session[:top_copy] = params["post"]["top_copy"]
    # session[:bottom_copy] = params["post"]["bottom_copy"]
    redirect_to graphics_path
  end

  def graphics
    @post = Post.new
    render 'posts/input'
  end

  def graphics_sessions
    session[:bottom_copy] = params["post"]["bottom_copy"]
    redirect_to preview_path
  end

  def preview

  end



  private

  def post_params
    params.require(:post).permit(:top_copy, :bottom_copy, :user_id, :language_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
