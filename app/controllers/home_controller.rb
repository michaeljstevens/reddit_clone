class HomeController < ApplicationController

  def index
    if params[:search]
      case params[:type]
      when "posts"
        @title = "Searched Posts"
        @posts = Post.where("lower(title) LIKE '%#{params[:search].downcase}%' OR lower(content) LIKE '%#{params[:search].downcase}%'")
      when "subs"
        @title = "Searched Subreddits"
        @subs = Sub.where("lower(title) LIKE '%#{params[:search].downcase}%' OR lower(description) LIKE '%#{params[:search].downcase}%'")
      end
      return
    end
    if current_user
      posts = current_user.subbed_posts
    else
      posts = Post.all
    end
    @title = "Subscribed Posts"
    @posts = posts.sort{ |a,b| b.vote_count <=> a.vote_count }
  end


end
