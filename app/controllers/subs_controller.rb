class SubsController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :find_sub, only: [:edit, :update, :destroy, :show]
  before_action :owner, only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @sub.destroy
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      redirect_to sub_url(@sub)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def find_sub
    @sub = Sub.find(params[:id])
  end

  def owner
    unless @sub.moderator == current_user
      flash[:errors] = ["You don't have permission to do that."]
      redirect_to sub_url(@sub)
    end
  end
end
