class PostsController < ApplicationController
#Need to give access to images, languages, input
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @posts = Post.all
    # Need to only render text if given, not "/posts/xx"
    render "posts/feed"
  end

  def show
    render 'posts/preview'
  end

  def new
    @post = Post.create
    render 'posts/emotions'
  end

  def create
    @post = Post.create(post_params)

    if @post.save
      # Redirect NOT WORKING properly - currently going to Preview
      redirect_to edit_post_path(@post)
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


  private

  def post_params
    params.require(:post).permit(:top_copy, :bottom_copy, :user_id, :language_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
