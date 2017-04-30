class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Welcome!'
      redirect_to home_path
    else
      session[:user_id] = nil
      flash[:error] = 'Your username or password was incorrect.'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have signed out.'
    redirect_to home_path
  end
end
