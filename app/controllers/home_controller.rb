class HomeController < ApplicationController

  def index
    if current_user
      posts = current_user.subbed_posts
    else
      posts = Post.all
    end
    @posts = posts.sort{ |a,b| b.vote_count <=> a.vote_count }
  end


end
