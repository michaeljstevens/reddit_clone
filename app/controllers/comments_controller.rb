class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :destroy, :upvote, :downvote]

  def upvote
    @comment.votes.new(value: 1)
    save(@comment)
  end

  def downvote
    @comment.votes.new(value: -1)
    save(@comment)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :show
    end
  end

  def show

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def owner
    unless @comment.author == current_user
      flash[:errors] = ["You don't have permission to do that."]
      redirect_to post_url(@comment.post)
    end
  end

end
