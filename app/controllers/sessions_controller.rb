class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid Login Credentials"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
