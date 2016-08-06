class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
  end

  def logout
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
  end

  def save(object)
    if object.save
      redirect_to :back
    else
      flash[:errors] = object.errors.full_messages
      redirect_to :back
    end
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    redirect_to new_session_url unless current_user
  end
end
