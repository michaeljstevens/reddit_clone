class PostsController < ApplicationController
  before_action :authenticate, except: [:show]
  before_action :find_post, only: [:edit, :update, :destroy, :show, :upvote, :downvote]
  before_action :owner, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def upvote
    @post.votes.new(value: 1)
    save(@post)
  end
  def downvote
    @post.votes.new(value: -1)
    save(@post)
  end

  def edit
  end

  def show
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to post_url(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def owner
    unless @post.author == current_user
      flash[:errors] = ["You don't have permission to do that."]
      redirect_to sub_url(@post.sub)
    end
  end
end
