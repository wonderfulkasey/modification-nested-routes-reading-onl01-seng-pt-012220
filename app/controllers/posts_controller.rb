class PostsController < ApplicationController

  def index
    if params[:author_id]

  else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
            if author.nil?
              redirect_to authors_path, alert: "Author not found."
            else
              @post = author.posts.find_by(id: params[:id])
              redirect_to author_posts_path(author), alert: "Post not found." if @post.nil?
            end
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
