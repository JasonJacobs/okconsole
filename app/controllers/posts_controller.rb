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
    render 'posts/input'
  end

  def create
    @post = current_user.posts.build#(post_params)
    @post.top_copy = session[:top_copy]
    @post.bottom_copy = session[:bottom_copy]
    @post.emoticon_id = session[:emoticon_id]
    @post.language_id = session[:language_id]
    @post.image_url = session[:image_url]
    if @post.save
     redirect_to @post
    else
      render 'posts/input'
    end
  end

  def edit
    render 'posts/input'
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Edited"
    else
      render 'posts/emotions'
    end
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  def copy_sessions
    session[:top_copy] = params["post"]["top_copy"]
    session[:bottom_copy] = params["post"]["bottom_copy"]
    redirect_to graphics_path
  end

  def graphics
    @post = Post.new
    render 'posts/emotions'
  end

  def graphics_sessions
    session[:emoticon_id] = params["post"]["emoticon_id"]
    session[:language_id] = params["post"]["language_id"]
    redirect_to preview_path
  end

  def preview
    @url = "http://apimeme.com/meme?meme=#{Post.random_option}&top=#{session[:top_copy]}&bottom=#{session[:bottom_copy]}"
    session[:image_url] = @url
  end



  private

  def post_params
    params.require(:post).permit(:top_copy, :bottom_copy, :user_id, :language_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
