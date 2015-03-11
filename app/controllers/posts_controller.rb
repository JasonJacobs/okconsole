class PostsController < ApplicationController
#Need to give access to images, languages, input
  def index
    @posts = Post.all
    render "posts/index"
  end

end
