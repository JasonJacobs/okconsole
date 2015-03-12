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
    @post = current_user.posts.build
    render 'posts/emotions'
  end

  def create
    @post = current_user.posts.build(post_params)

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

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end


  private

  def post_params
    params.require(:post).permit(:top_copy, :bottom_copy, :user_id, :language_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
